<?php
namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use App\Models\Income;
use App\Models\FinanceGroup;

// voyager
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Middleware\VoyagerAdminMiddleware;


class IncomeController extends \TCG\Voyager\Http\Controllers\VoyagerBreadController
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
            $requests = Income::where('user_id', Auth::user()->id)->orderBy($sort_order_field->value, "asc");
        } else {
            $requests = Income::where('user_id', Auth::user()->id)->orderBy("id","DESC");
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

        $view = 'voyager.income.browse';

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
        $validKey = array('group_id','title','description','amount','attachment','debited_at', 'user_id');
        
        $new = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $new->put($key,$request->input($key));
            }
            if($request->file('attachment') && $key == "attachment") {
                $image = $request->file('attachment');
                $path = Storage::disk('public')->put('income', $image);
                //dd($path);
                $new->put($key, $path);
            }
            if($key == 'user_id'){
                $new->put($key, Auth::user()->id);
            }
        }

        $newIncome = Income::create($new->toArray());

        $newIncome->load("group");

        $newIncome->debited_at = $newIncome->debited_at ? Carbon::create($newIncome->debited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=> $newIncome]);   
    }

    public function ajax_edit(Request $request)
    {
        $validKey = array('id','group_id','title','description','amount','attachment','debited_at');
        
        $update = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $update->put($key,$request->input($key));
            }
            if($request->file('attachment') && $key == "attachment") {
                $image = $request->file('attachment');
                $path = Storage::disk('public')->put('income', $image);
                $update->put($key, $path);
            }
        }

        $updateIncome = Income::where("id", $request->id)->first();

        if($request->file('attachment') && $updateIncome->attachment 
            && Storage::disk('public')->exists($updateIncome->attachment)) {
            Storage::disk('public')->delete($updateIncome->attachment);
        }

        $updateIncome->update($update->toArray());

        $updateIncome->load("group");

        $updateIncome->debited_at = $updateIncome->debited_at ? Carbon::create($updateIncome->debited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=>$updateIncome]);   
    }

    public function ajax_delete(Request $request){
        
        $delete_id = $request->id;

        if($delete_id){

            $income = Income::where("id", $delete_id)->first();

            if($income->attachment && Storage::disk('public')->exists($income->attachment)) { 
                Storage::disk('public')->delete($income->attachment); 
            }

            $income->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted income"]);  

        } else {
            return response()->json(['income id is required'], 422); 
        }
    }

    public function ajax_bulk_delete(Request $request){
        
        $delete_ids = $request->delete_array;

        if(count($delete_ids) > 0){

            $incomes = Income::whereIn('id', $delete_ids)->get();

            foreach($incomes as $income){
                if($income->attachment && Storage::disk('public')->exists($income->attachment)) { 
                    Storage::disk('public')->delete($income->attachment); 
                }
            }

            Income::whereIn('id', $delete_ids)->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted incomes"]);

        } else {
            return response()->json(['income ids is required'], 422); 
        }
    }
}