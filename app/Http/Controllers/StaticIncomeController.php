<?php
namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use App\Models\StaticIncome;
use App\Models\FinanceGroup;

// voyager
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Middleware\VoyagerAdminMiddleware;


class StaticIncomeController extends \TCG\Voyager\Http\Controllers\VoyagerBreadController
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
            $requests = StaticIncome::where('user_id', Auth::user()->id)->orderBy($sort_order_field->value, "asc");
        } else {
            $requests = StaticIncome::where('user_id', Auth::user()->id)->orderBy("id","DESC");
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

        $view = 'voyager.static-income.browse';

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
        $validKey = array('group_id','title','description','amount','debit_day_per_month','user_id');
        
        $new = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $new->put($key,$request->input($key));
            }
            if($key == 'user_id'){
                $new->put($key, Auth::user()->id);
            }
            if($key == 'amount'){
                if(! fmod($request->input($key), 1) !== 0.00){
                    $new->put($key, number_format($request->input($key), 2, '.', ''));
                }
            }
        }

        $newStaticIncome = StaticIncome::create($new->toArray());

        $newStaticIncome->load("group");

        $newStaticIncome->debited_at = $newStaticIncome->debited_at ? Carbon::create($newStaticIncome->debited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=> $newStaticIncome]);   
    }

    public function ajax_edit(Request $request)
    {
        $validKey = array('id','group_id','title','description','amount','debit_day_per_month');
        
        $update = collect();

        foreach($validKey as $key){
            if($request->input($key)!= null){
                $update->put($key,$request->input($key));
            }
            if($key == 'amount'){
                if(! fmod($request->input($key), 1) !== 0.00){
                    $new->put($key, number_format($request->input($key), 2, '.', ''));
                }
            }
        }

        $updateStaticIncome = StaticIncome::where("id", $request->id)->first();

        $updateStaticIncome->update($update->toArray());

        $updateStaticIncome->load("group");

        $updateStaticIncome->debited_at = $updateStaticIncome->debited_at ? Carbon::create($updateStaticIncome->debited_at)->addHour(8)->format('Y-m-d H:i:s') : null;
        
        return response()->json(["success"=>true,"message"=>$updateStaticIncome]);   
    }

    public function ajax_delete(Request $request){
        
        $delete_id = $request->id;

        if($delete_id){

            $staticIncome = StaticIncome::where("id", $delete_id)->first();

            $staticIncome->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted static income"]);  

        } else {
            return response()->json(['static income id is required'], 422); 
        }
    }

    public function ajax_bulk_delete(Request $request){
        
        $delete_ids = $request->delete_array;

        if(count($delete_ids) > 0){

            StaticIncome::whereIn('id', $delete_ids)->delete();

            return response()->json(["success"=>true,"message"=>"Successfully deleted static incomes"]);

        } else {
            return response()->json(['static income ids is required'], 422); 
        }
    }
}