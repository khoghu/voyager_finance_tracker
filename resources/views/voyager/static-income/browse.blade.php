@extends('voyager::master')

@section('page_title', 'Static Incomes')

@section('page_header')
    <div class="container-fluid">
        <h1 class="page-title">
            <i class="{{ $dataType->icon }}"></i> {{ $dataType->getTranslatedAttribute('display_name_plural') }}
        </h1>
        @can('add', app($dataType->model_name))
            <a data-toggle="modal" data-target="#newStaticIncomeModal" class="btn btn-success add btn-add-new">
                <i class="voyager-plus"></i> <span>{{ __('voyager::generic.add_new') }}</span>
            </a>
        @endcan
        @can('delete', app($dataType->model_name))
            <a class="btn btn-danger bulk-delete">
                <i class="voyager-trash"></i> <span>{{ __('voyager::generic.bulk_delete') }}</span>
            </a>
        @endcan
        @include('voyager::multilingual.language-selector')
    </div>
@stop
@section('content')
    <div class="page-content browse container-fluid">
        @include('voyager::alerts')
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        <div style="display:flex;">
                            <form method="get" class="form-search">
                                <div id="search-input" style="width:230px;">
                                    <div class="input-group col-md-12">
                                        <input type="text" class="form-control" placeholder="{{ __('voyager::generic.search') }}" name="s" value="{{ $search->value }}">
                                        <button class="btn btn-info btn-lg" type="submit">
                                            <i class="voyager-search"></i>
                                        </button>
                                    </div>
                                </div>
                                @if (Request::has('sort_order') && Request::has('order_by'))
                                    <input type="hidden" name="sort_order" value="{{ Request::get('sort_order') }}">
                                    <input type="hidden" name="order_by" value="{{ Request::get('order_by') }}">
                                @endif
                            </form>
                            <select name="sort_option" id="sort_field">
                                <option value="" selected>Sort by Fields</option>
                                <option value="id">ID</option>
                                <option value="title">Title</option>
                                <option value="description">Description</option>
                                <option value="amount">Amount</option>
                                <option value="debit_day_per_month">Debit Day Per Month</option>
                            </select>
                        </div>
                        <div class="table-responsive">
                            <table id="dataTable2" class="table">
                                <thead>
                                    <tr>
                                       <th><input type="checkbox" check_type="all"></th>
                                       <th>ID</th>
                                       <th>Group</th>
                                       <th>Title</th>
                                       <th>Description</th>
                                       <th>Amount</th>
                                       <th>Debit Day Per Month</th>
                                       <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="pending-tbody">
                                     @foreach($requests as $request)
                                        <tr class="table-row" row_id="{{$request->id}}">
                                            <td><input type="checkbox" check_type="{{$request->id}}"></td>
                                            <td class="id">{{ $request->id }}</td>
                                            <td class="group_id" group_id="{{$request->group_id}}">{{ $request->group->name }}</td>
                                            <td class="title">{{ $request->title }}</td>
                                            <td class="description">{{ $request->description }}</td>
                                            <td class="amount" amount="{{ $request->amount }}">RM {{ $request->amount }}</td>
                                            <td class="debit_day_per_month">{{ $request->debit_day_per_month }}</td>
                                            <td>
                                                <div class="table-actions-btn">
                                                    <div class="edit" edit_id="{{$request->id}}"><i class="voyager-edit"></i>Edit</div>
                                                    <div class="delete" delete_id="{{$request->id}}" data-toggle="modal" data-target="#delete_modal"><i class="voyager-trash"></i>Delete</div> 
                                                </div>
                                            </td>
                                        </tr>  
                                    @endforeach                    
                                </tbody>
                            </table>
                        </div>
                        <div class="pull-left">
                            <div role="status" class="show-res" aria-live="polite">{{ trans_choice(
                                'voyager::generic.showing_entries', $requests->total(), [
                                    'from' => $requests->firstItem(),
                                    'to' => $requests->lastItem(),
                                    'all' => $requests->total()
                                ]) }}</div>
                        </div>
                        <div class="pull-right">{{$requests->links()}}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @include('voyager.static-income.staticIncomeModals')
    
@stop

@section('css')
    <link rel="stylesheet" href="{{asset('css/responsive.dataTables.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/bootstrap-select.min.css') }}">
    <link rel="stylesheet" href="{{asset('css/common.css') }}">
@stop

@section('javascript')
    <!-- DataTables -->
    <script src="{{asset('js/responsive.dataTables.min.js')}}"></script>
    <script src="{{asset('js/bootstrap-select.min.js')}}"></script>
    <script type="text/javascript" src="{{ asset('js/common.js') }}"></script>
    <script>
        var bulk_delete_array = []
        var delete_id;
        $(document).ready(function () {
            $("#sort_field").on("change", function(){
                reroute(api("static-incomes?sort="+$(this).val()));
            })
            $(".add").on("click", function(){
                $(".new-static-income")[0].reset()
            })
            $("#pending-tbody").on("click", ".edit", function(){
                var tbody_row = $("tr[row_id='"+ $(this).attr("edit_id") +"']")
                tbody_row.find('td').each(function(index) {
                    console.log(index + " = " + $(this).text())
                    if($(this).attr('class') == 'group_id'){
                        $("#editStaticIncomeModal").find("select[name='"+$(this).attr('class')+"']").val($(this).attr('group_id'));
                    } else if($(this).attr('class') == 'amount'){
                        $("#editStaticIncomeModal").find("input[name='"+$(this).attr('class')+"']").val($(this).attr('amount'));
                    } else if (index != 0 && index != 7) {
                        $("#editStaticIncomeModal").find("input[name='"+$(this).attr('class')+"']").val($(this).text());
                    }
                })
                $('#editStaticIncomeModal').modal('toggle');
            })
            
            $(".new-static-income").on("submit",add_static_income);
            $(".update-static-income").on("submit", update_static_income);
            $(".delete_confirm").on("click", function() { delete_record('static-incomes', delete_id) })
            $(".bulk_delete_confirm").on("click", function() { delete_bulk_records('static-incomes', bulk_delete_array) })
        });

        //add new record
        function add_static_income(e){
            e.preventDefault();
            $.ajax({
                url:api("static-incomes/ajax_add"),
                type:"POST",
                dataType: "JSON",
                data: new FormData(this),
                processData: false,
                contentType: false,
                success:function(data){
                    // console.log("pass");
                    // console.log(data);
                    if(data.success) {
                        $("#pending-tbody").prepend('<tr class="table-row" row_id="'+ data.message.id +'">')
                        var tbody_row = $("tr[row_id='"+ data.message.id +"']")
                        tbody_row.append('<td><input type="checkbox" check_type="'+ data.message.id +'"></td>')
                        tbody_row.append('<td class="id">'+ data.message.id +'</td>')
                        tbody_row.append('<td class="group_id" group_id="'+ data.message.group_id +'">'+ data.message.group.name +'</td>')
                        tbody_row.append('<td class="title">'+ data.message.title +'</td>')
                        tbody_row.append('<td class="description">'+ data.message.description +'</td>')
                        tbody_row.append('<td class="amount" amount="'+ data.message.amount +'">RM '+ data.message.amount +'</td>')
                        tbody_row.append('<td class="debit_day_per_month">'+ data.message.debit_day_per_month +'</td>')
                        tbody_row.append('<td><div class="table-actions-btn"></div></td>')
                        tbody_row.find(".table-actions-btn").append('<div class="edit" edit_id="'+ data.message.id +'"><i class="voyager-edit"></i>Edit</div>')
                        tbody_row.find(".table-actions-btn").append('<div class="delete" delete_id="'+ data.message.id +'" data-toggle="modal" data-target="#delete_modal"><i class="voyager-trash"></i>Delete</div> ')
                        toastr.success("Added Successfully.");
                        $('#newStaticIncomeModal').modal('toggle');
                        $('.new-static-income')[0].reset()
                    }
                },
                error:function(error){
                    console.log("fail");
                    var error = eval("(" + error.responseText + ")");
                    console.log(error);
                    toastr.error("Something went wrong.")
                }
            });
        }

        //edit record
        function update_static_income(e){
            e.preventDefault();
            $.ajax({
                url:api("static-incomes/ajax_edit"),
                type:"POST",
                dataType: "JSON",
                data: new FormData(this),
                processData: false,
                contentType: false,
                success:function(data){
                    // console.log("pass");
                    // console.log(data);
                    if(data.success) {
                        var tbody_row = $("tr[row_id='"+ data.message.id +"']")
                        $.each(data.message, function(key, value) {
                            if(key == 'group_id'){
                                tbody_row.find("."+key).attr(key, value).text(data.message.group.name);
                            } else if (key == 'amount') {
                                tbody_row.find("."+key).attr(key, value).text("RM "+value);
                            } else {
                                tbody_row.find("."+key).text(value);
                            }
                        });
                        toastr.success("Update Successfully.");
                        $('#editStaticIncomeModal').modal('toggle');
                        $('.update-static-income')[0].reset()
                    }
                },
                error:function(error){
                    console.log("fail");
                    var error = eval("(" + error.responseText + ")");
                    console.log(error);
                    toastr.error("Something went wrong.")
                }
            });
        }
    </script>
@stop
