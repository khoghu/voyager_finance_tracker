<?php
namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use App\Models\Expense;
use App\Models\FinanceGroup;

// voyager
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Middleware\VoyagerAdminMiddleware;


class ExpenseController extends \TCG\Voyager\Http\Controllers\VoyagerBreadController
{
    public function __construct()
    {
        $this->middleware(VoyagerAdminMiddleware::class);
    }

    public function my_index(Request $request)
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = $this->getSlug($request);

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $orderBy = $request->get('order_by', "");
        $orderColumn = $request->get('order_by', "");
        $sortOrder = $request->get('order_by', "");
        $search = (object) [
            'value' => $request->get('s'), 'key' => $request->get('key'),
        ];
        $sort_order_field = (object) [
            'value' => $request->get('sort'), 'key' => $request->get('key'),
        ];

        if($sort_order_field->value) {
            $requests = Expense::where('user_id', Auth::user()->id)->orderBy($sort_order_field->value, "asc");
        } else {
            $requests = Expense::where('user_id', Auth::user()->id)->orderBy("id","DESC");
        }

        if($search->value){
            $term =$search->value;
            $requests =
            $requests
            //scope search
            ->where(function($base) use ($term){
                $base
                //allow more
                ->orWhere(function($q_base2) use ($term){
                    return $q_base2->when($term, function ($q) use ($term) {
                        $q
                        ->orWhere('id', 'LIKE', '%'.$term.'%')
                        ->orWhere('title', 'LIKE', '%'.$term.'%');
                    });
                });
            });
        }

        $groups = FinanceGroup::all();

        $requests = $requests->paginate(10)->withQueryString();

        $view = 'voyager.expense.browse';

        return Voyager::view($view, compact(
            'search',
            'orderBy',
            'orderColumn',
            'sortOrder',
            'requests',
            'dataType',
            'groups',
        ));
    }

    public function ajax_add(Request $request)
    {
        $validKey = array('group_id','title','description','amount','attachment','credited_at','user_id','status');
        
        $new = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $new->put($key,$request->input($key));
            }
            if($request->file('attachment') && $key == "attachment") {
                $image = $request->file('attachment');
                $path = Storage::disk('public')->put('expense', $image);
                //dd($path);
                $new->put($key, $path);
            }
            if($key == 'user_id'){
                $new->put($key, Auth::user()->id);
            }
            if($key == 'status'){
                if($request->input($key)){
                    $new->put($key, $request->input($key));
                } else {
                    $new->put($key, 'Pending');
                }
            }
        }

        $newExpense = Expense::create($new->toArray());

        $newExpense->load("group");

        $newExpense->credited_at = $newExpense->credited_at ? Carbon::create($newExpense->credited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=> $newExpense]);   
    }

    public function ajax_edit(Request $request)
    {
        $validKey = array('id','group_id','title','description','amount','attachment','credited_at','status');
        
        $update = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $update->put($key,$request->input($key));
            }
            if($request->file('attachment') && $key == "attachment") {
                $image = $request->file('attachment');
                $path = Storage::disk('public')->put('expense', $image);
                $update->put($key, $path);
            } 
            if($key == 'status'){
                if($request->input($key)){
                    $update->put($key, $request->input($key));
                } else {
                    $update->put($key, 'Pending');
                }
            }
        }

        $updateExpense = Expense::where("id", $request->id)->first();

        if($request->file('attachment') && $updateExpense->attachment 
            && Storage::disk('public')->exists($updateExpense->attachment)) {
            Storage::disk('public')->delete($updateExpense->attachment);
        }

        $updateExpense->update($update->toArray());

        $updateExpense->load("group");

        $updateExpense->credited_at = $updateExpense->credited_at ? Carbon::create($updateExpense->credited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=>$updateExpense]);   
    }

    public function ajax_delete(Request $request){
        
        $delete_id = $request->id;

        if($delete_id){

            $expense = Expense::where("id", $delete_id)->first();

            if($expense->attachment && Storage::disk('public')->exists($expense->attachment)) { 
                Storage::disk('public')->delete($expense->attachment); 
            }

            $expense->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted expense"]);  

        } else {
            return response()->json(['expense id is required'], 422); 
        }
    }

    public function ajax_bulk_delete(Request $request){
        
        $delete_ids = $request->delete_array;

        if(count($delete_ids) > 0){

            $expenses = Expense::whereIn('id', $delete_ids)->get();

            foreach($expenses as $expense){
                if($expense->attachment && Storage::disk('public')->exists($expense->attachment)) { 
                    Storage::disk('public')->delete($expense->attachment); 
                }
            }

            Expense::whereIn('id', $delete_ids)->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted expenses"]);

        } else {
            return response()->json(['expenses ids is required'], 422); 
        }
    }
}