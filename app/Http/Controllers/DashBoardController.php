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
use App\Models\Income;
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
        $currentDate = Carbon::now();
        $today = $currentDate->toDateString();
        $currentMonth = Carbon::now()->month;
        $currentYear = Carbon::now()->year;
        $currentMonthGroupExpenseName = [];
        $currentMonthGroupExpenseCount = [];
        $pastSixMonths = [];    

        // GET THE MenuItem for dashboard
        $menuItem = Voyager::model('MenuItem')->where('title', '=', 'Dashboard')->first();

        $todayTotalExpense = Expense::where('status', 'Complete')
                                    ->where('user_id', Auth::user()->id)
                                    ->whereDate('created_at', $today)->sum('amount');
        $todayTotalExpense = 'RM '.number_format($todayTotalExpense, 2, '.', '');

        $currentMonthTotalExpense = Expense::where('status', 'Complete')
                                           ->where('user_id', Auth::user()->id)
                                           ->whereMonth('created_at', '=', $currentMonth)
                                           ->whereYear('created_at', '=', $currentYear)->sum('amount');

        $currentMonthTotalIncome = Income::where('user_id', Auth::user()->id)
                                         ->whereMonth('created_at', '=', $currentMonth)
                                         ->whereYear('created_at', '=', $currentYear)->sum('amount');

        $currentMonthBalance = 'RM '.number_format($currentMonthTotalIncome - $currentMonthTotalExpense, 2, '.', '');

        $currentMonthTotalIncome = 'RM '.number_format($currentMonthTotalIncome, 2, '.', '');

        $currentMonthTotalExpense = 'RM '.number_format($currentMonthTotalExpense, 2, '.', '');

        
        for ($i = 5; $i >= 0; $i--) {
            $month = Carbon::now()->subMonths($i)->format('F');
            $pastSixMonths[] = $month;
        }

        // Calculate the date 6 months ago
        $sixMonthsAgo = $currentDate->subMonths(6);

        // Use Eloquent to query and get the counts of records from the past 6 months
        $expenseCounts = Expense::selectRaw('COUNT(*) as count')
                                ->where('status', 'Complete')
                                ->whereDate('created_at', '>=', $sixMonthsAgo)
                                ->groupBy(DB::raw('MONTH(created_at)'))
                                ->orderBy(DB::raw('MONTH(created_at)'), "DESC")
                                ->pluck('count')->toArray();
        
        // Merge the counts with the months array and fill months with zero counts
        $pastSixMontExpenseCounts = [];
        for ($i = 5; $i >= 0; $i--) {
            $pastSixMontExpenseCounts[] = $expenseCounts[$i] ?? 0;
        }

        // Use Eloquent to query and get the count of records for the current month, grouped by the 'type' field
        $currentMonthGroupExpenses = Expense::join('finance_groups', 'finance_groups.id', '=', 'expenses.group_id')
                                           ->select('finance_groups.name', DB::raw('COUNT(*) as count'))
                                           ->where('expenses.status', 'Complete')
                                           ->whereMonth('expenses.created_at', '=', $currentMonth)
                                           ->whereYear('expenses.created_at', '=', $currentYear)
                                           ->groupBy('finance_groups.name')
                                           ->get()->toArray();

       

        foreach($currentMonthGroupExpenses as $currentMonthGroupExpense){
            $currentMonthGroupExpenseName[] = $currentMonthGroupExpense['name'];
            $currentMonthGroupExpenseCount[] = $currentMonthGroupExpense['count'];
        }

        // Get the 10 most recent records
        $recentActivity = Expense::orderBy("id","DESC")->latest()->take(10)->get();

        

        return Voyager::view('voyager.index', compact(
            'menuItem',
            'todayTotalExpense',
            'currentMonthTotalExpense',
            'currentMonthTotalIncome',
            'currentMonthBalance',
            'pastSixMonths',
            'pastSixMontExpenseCounts',
            'currentMonthGroupExpenseName',
            'currentMonthGroupExpenseCount',
            'recentActivity'
        ));
    }
}