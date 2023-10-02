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
        <div class="count_record">
            <div class="record_list" class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Today Expense</h4>
                    <h1>{{ $todayTotalExpense }}</h1>
                </div>
            </div>
            <div class="record_list" class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Current Month Expense</h4>
                    <h1>{{ $currentMonthTotalExpense }}</h1>
                </div>
            </div>
            <div class="record_list" class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Total Current Month Income</h4>
                    <h1>{{ $currentMonthTotalIncome }}</h1>
                </div>
            </div>
            <div class="record_list" class="col-md-3">
                <div class="list_count card card-body mb-3">
                    <h4>Balance Current Month</h4>
                    <h1>{{ $currentMonthBalance }}</h1>
                </div>
            </div>
        </div>
        <div class="chart_css">
            <div class="chart_css_list">
                <canvas id="myChart" width="200"></canvas>
            </div>
            <div class="chart_css_list">
                <canvas id="myChart2" width="200"></canvas>
            </div>
        </div>
        <div class="recent_activity">
            <h4>Recent Activity</h4>
            <div class="table-responsive">
                <table id="dataTable2" class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Group</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Amount</th>
                            <th>Attachment</th>
                            <th>Status</th>
                            <th>Credited At</th>
                        </tr>
                    </thead>
                    <tbody id="pending-tbody">
                            @foreach($recentActivity as $request)
                            <tr class="table-row" row_id="{{$request->id}}">
                                <td class="id">{{ $request->id }}</td>
                                <td class="group_id" group_id="{{$request->group_id}}">{{ $request->group->name }}</td>
                                <td class="title">{{ $request->title }}</td>
                                <td class="description">@if($request->description) {{ $request->description }} @endif</td>
                                <td class="amount" amount="{{ $request->amount }}">RM {{ $request->amount }}</td>
                                <td class="attachment">
                                    @if($request->attachment)
                                    <img data-toggle="modal" data-target="#imagemodal_4" src="http://127.0.0.1:8000/storage/{{ $request->attachment }}" style="width:120px; cursor:pointer;">
                                    @endif
                                </td>
                                <td class="status" style="font-weight:bold; @if($request->status == 'Pending') color:#dbad05; @else color:#1cba03; @endif">{{ $request->status }}</td>
                                <td class="credited_at">
                                    @if($request->credited_at)
                                        {{ $request->credited_at }}
                                    @endif
                                </td>
                            </tr>  
                        @endforeach                    
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- image display modal -->
    <div id="imagemodal_4" class="modal fade" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                </div> 
                <div class="modal-body">
                    <img src="http://127.0.0.1:8000/storage/users/default.png" class="img img-responsive" style="margin: 0px auto;">
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
    <style>
        .page-content{
            margin: 0px 30px;
        }
    </style>
    <link rel="stylesheet" href="{{asset('css/responsive.dataTables.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/bootstrap-select.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/common.css') }}">
@stop

@section('javascript')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="{{asset('js/responsive.dataTables.min.js')}}"></script>
    <script src="{{asset('js/bootstrap-select.min.js')}}"></script>
    <script type="text/javascript" src="{{ asset('js/common.js') }}"></script>
    <script>
        const ctx = document.getElementById('myChart');
        const ctx2 = document.getElementById('myChart2');
        const currentMonthGroupExpenseCount = {!! json_encode($currentMonthGroupExpenseCount) !!}

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: {!! json_encode($pastSixMonths) !!},
                datasets: [{
                    label: 'Past 6 Months Expense',
                    data: {!! json_encode($pastSixMontExpenseCounts) !!},
                    backgroundColor: [
                        'rgb(54, 162, 235)',
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        new Chart(ctx2, {
            type: 'pie',
            data:  {
                labels: {!! json_encode($currentMonthGroupExpenseName) !!},
                datasets: [{
                    data: currentMonthGroupExpenseCount,
                    backgroundColor: getRandomColor(currentMonthGroupExpenseCount.length),
                    hoverOffset: 4
                }]
            },
        });

        function getRandomColor(count) {
            const letters = '0123456789ABCDEF';
            var color_array = [];
            for(let c = 0; c < count; c++){
                let color = '#';
                for (let i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                color_array.push(color)
            }
            return color_array;
        }
    </script>
@stop
