<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\IncomeController;
use App\Http\Controllers\ExpenseController;
use App\Http\Controllers\StaticIncomeController;
use App\Http\Controllers\StaticExpenseController;
use App\Http\Controllers\DashBoardController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::group(['prefix' => 'admin'], function () {
    
    Voyager::routes();

    // login
    Route::post('login', [UserController::class, 'postLogin'])->name('voyager.login');

    // dashboard
    Route::get('/', [DashBoardController::class, 'my_index'])->name('voyager.dashboard');

    // income
    Route::get('incomes', [IncomeController::class, 'my_index'])->name('voyager.incomes.index');
    Route::post('incomes/ajax_add', [IncomeController::class, 'ajax_add'])->name('voyager.incomes.ajax_add');
    Route::post('incomes/ajax_edit', [IncomeController::class, 'ajax_edit'])->name('voyager.incomes.ajax_edit');
    Route::post('incomes/ajax_delete', [IncomeController::class, 'ajax_delete'])->name('voyager.incomes.ajax_delete');
    Route::post('incomes/ajax_bulk_delete', [IncomeController::class, 'ajax_bulk_delete'])->name('voyager.incomes.ajax_bulk_delete');

    // expense
    Route::get('expenses', [ExpenseController::class, 'my_index'])->name('voyager.expenses.index');
    Route::post('expenses/ajax_add', [ExpenseController::class, 'ajax_add'])->name('voyager.expenses.ajax_add');
    Route::post('expenses/ajax_edit', [ExpenseController::class, 'ajax_edit'])->name('voyager.expenses.ajax_edit');
    Route::post('expenses/ajax_delete', [ExpenseController::class, 'ajax_delete'])->name('voyager.expenses.ajax_delete');
    Route::post('expenses/ajax_bulk_delete', [ExpenseController::class, 'ajax_bulk_delete'])->name('voyager.expenses.ajax_bulk_delete');

    // static income
    Route::get('static-incomes', [StaticIncomeController::class, 'my_index'])->name('voyager.static-incomes.index');
    Route::post('static-incomes/ajax_add', [StaticIncomeController::class, 'ajax_add'])->name('voyager.static-incomes.ajax_add');
    Route::post('static-incomes/ajax_edit', [StaticIncomeController::class, 'ajax_edit'])->name('voyager.static-incomes.ajax_edit');
    Route::post('static-incomes/ajax_delete', [StaticIncomeController::class, 'ajax_delete'])->name('voyager.static-incomes.ajax_delete');
    Route::post('static-incomes/ajax_bulk_delete', [StaticIncomeController::class, 'ajax_bulk_delete'])->name('voyager.static-incomes.ajax_bulk_delete');

    // static expense
    Route::get('static-expenses', [StaticExpenseController::class, 'my_index'])->name('voyager.static-expenses.index');
    Route::post('static-expenses/ajax_add', [StaticExpenseController::class, 'ajax_add'])->name('voyager.static-expenses.ajax_add');
    Route::post('static-expenses/ajax_edit', [StaticExpenseController::class, 'ajax_edit'])->name('voyager.static-expenses.ajax_edit');
    Route::post('static-expenses/ajax_delete', [StaticExpenseController::class, 'ajax_delete'])->name('voyager.static-expenses.ajax_delete');
    Route::post('static-expenses/ajax_bulk_delete', [StaticExpenseController::class, 'ajax_bulk_delete'])->name('voyager.static-expenses.ajax_bulk_delete');
});
