<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\IncomeController;
use App\Http\Controllers\StaticIncomeController;

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

    // income
    Route::get('incomes', [IncomeController::class, 'my_index'])->name('voyager.incomes.index');
    Route::post('incomes/ajax_add', [IncomeController::class, 'ajax_add'])->name('voyager.incomes.ajax_add');
    Route::post('incomes/ajax_edit', [IncomeController::class, 'ajax_edit'])->name('voyager.incomes.ajax_edit');
    Route::post('incomes/ajax_delete', [IncomeController::class, 'ajax_delete'])->name('voyager.incomes.ajax_delete');
    Route::post('incomes/ajax_bulk_delete', [IncomeController::class, 'ajax_bulk_delete'])->name('voyager.incomes.ajax_bulk_delete');

    // static income
    Route::get('static-incomes', [StaticIncomeController::class, 'my_index'])->name('voyager.static-incomes.index');
    Route::post('static-incomes/ajax_add', [StaticIncomeController::class, 'ajax_add'])->name('voyager.static-incomes.ajax_add');
    Route::post('static-incomes/ajax_edit', [StaticIncomeController::class, 'ajax_edit'])->name('voyager.static-incomes.ajax_edit');
    Route::post('static-incomes/ajax_delete', [StaticIncomeController::class, 'ajax_delete'])->name('voyager.static-incomes.ajax_delete');
    Route::post('static-incomes/ajax_bulk_delete', [StaticIncomeController::class, 'ajax_bulk_delete'])->name('voyager.static-incomes.ajax_bulk_delete');
});
