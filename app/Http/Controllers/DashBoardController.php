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


class DashBoardController extends \TCG\Voyager\Http\Controllers\VoyagerController
{
    public function __construct()
    {
        $this->middleware(VoyagerAdminMiddleware::class);
    }

    public function my_index(Request $request)
    {

        // GET THE MenuItem for dashboard
        $menuItem = Voyager::model('MenuItem')->where('title', '=', 'Dashboard')->first();

        return Voyager::view('voyager.index', compact(
            'menuItem',
        ));
    }
}