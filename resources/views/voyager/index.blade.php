@extends('voyager::master')

@section('page_title', 'Dashboard')

@section('page_header')
    <div class="container-fluid">
        <h1 class="page-title">
            <i class="{{ $menuItem->icon_class }}"></i> {{ $menuItem->title }}
        </h1>
        @include('voyager::multilingual.language-selector')
    </div>
@stop

@section('content')
    <div class="page-content">
        @include('voyager::alerts')
        <div style="display: flex;justify-content: space-between;">
            <div class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Orders</h4>
                    <h1>4</h1>
                </div>
            </div>
            <div class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Orders</h4>
                    <h1>4</h1>
                </div>
            </div>
            <div class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Orders</h4>
                    <h1>4</h1>
                </div>
            </div>
            <div class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Orders</h4>
                    <h1>4</h1>
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
    <style>
        .list_count{
            padding:10px; 
            border-radius:20px; 
            text-align: center; 
            border: solid 2px cornflowerblue !important;
        }
    </style>
    <link rel="stylesheet" href="{{asset('css/responsive.dataTables.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/bootstrap-select.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/common.css') }}">
@stop
