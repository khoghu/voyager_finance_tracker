@extends('voyager::master')

@section('page_title', 'Incomes')

@section('page_header')
    <div class="container-fluid">
        <h1 class="page-title">
            <i class="{{ $dataType->icon }}"></i> {{ $dataType->getTranslatedAttribute('display_name_plural') }}
        </h1>
        @can('add', app($dataType->model_name))
            <a data-toggle="modal" data-target="#newIncomeModal" class="btn btn-success add btn-add-new">
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
                                <option value="debited_at">Debited At</option>
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
                                       <th>Attachment</th>
                                       <th>Debited At</th>
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
                                            <td class="description">@if($request->description) {{ $request->description }} @endif</td>
                                            <td class="amount" amount="{{ $request->amount }}">RM {{ $request->amount }}</td>
                                            <td class="attachment">
                                                @if($request->attachment)
                                                <img data-toggle="modal" data-target="#imagemodal_4" src="http://127.0.0.1:8000/storage/{{ $request->attachment }}" style="width:120px; cursor:pointer;">
                                                @endif
                                            </td>
                                            <td class="debited_at">
                                                @if($request->debited_at)
                                                    {{ $request->debited_at }}
                                                @endif
                                            </td>
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

    @include('voyager.income.incomeModals')
    
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
            select2Customize("newIncomeModal", "editIncomeModal")
            $("#sort_field").on("change", function(){
                reroute(api("incomes?sort="+$(this).val()));
            })
            $(".add").on("click", function(){
                $(".new-income")[0].reset()
                $("#select-drop-down-add").val('').trigger('change');
            })
            $("#pending-tbody").on("click", ".edit", function(){
                var tbody_row = $("tr[row_id='"+ $(this).attr("edit_id") +"']")
                tbody_row.find('td').each(function(index) {
                    if($(this).attr('class') == 'group_id'){
                        $("#editIncomeModal").find("select[name='"+$(this).attr('class')+"']").val($(this).attr('group_id')).trigger('change');
                    } else if($(this).attr('class') == 'amount'){
                        $("#editIncomeModal").find("input[name='"+$(this).attr('class')+"']").val($(this).attr('amount'));
                    } else if (index != 0 && index != 6 && index != 8) {
                        $("#editIncomeModal").find("input[name='"+$(this).attr('class')+"']").val($(this).text());
                    }
                })
                $('#editIncomeModal').modal('toggle');
            })
            
            $(".new-income").on("submit",add_income);
            $(".update-income").on("submit", update_income);
            $(".delete_confirm").on("click", function() { delete_record('incomes', delete_id) })
            $(".bulk_delete_confirm").on("click", function() { delete_bulk_records('incomes', bulk_delete_array) })
        });

        //add new record
        function add_income(e){
            e.preventDefault();
            $.ajax({
                url:api("incomes/ajax_add"),
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
                        if(data.message.description ){
                            tbody_row.append('<td class="description">'+ data.message.description +'</td>')
                        } else {
                            tbody_row.append('<td class="description"></td>')
                        }
                        tbody_row.append('<td class="amount" amount="'+ data.message.amount +'">RM '+ data.message.amount +'</td>')
                        if(data.message.attachment){
                            tbody_row.append('<td data-toggle="modal" data-target="#imagemodal_4" class="attachment"><img src="http://127.0.0.1:8000/storage/'+ data.message.attachment +'" style="width:120px; cursor:pointer;"></td>')
                        } else {
                            tbody_row.append('<td class="attachment"></td>')
                        }
                        if(data.message.debited_at){
                            tbody_row.append('<td class="debited_at">'+ data.message.debited_at.substring(0, 19).replace("T", " ") +'</td>')
                        } else {
                            tbody_row.append('<td class="debited_at"></td>')
                        }
                        tbody_row.append('<td><div class="table-actions-btn"></div></td>')
                        tbody_row.find(".table-actions-btn").append('<div class="edit" edit_id="'+ data.message.id +'"><i class="voyager-edit"></i>Edit</div>')
                        tbody_row.find(".table-actions-btn").append('<div class="delete" delete_id="'+ data.message.id +'" data-toggle="modal" data-target="#delete_modal"><i class="voyager-trash"></i>Delete</div> ')
                        toastr.success("Added Successfully.");
                        $('#newIncomeModal').modal('toggle');
                        $('.new-income')[0].reset()
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
        function update_income(e){
            e.preventDefault();
            $.ajax({
                url:api("incomes/ajax_edit"),
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
                            } else if (key == 'attachment' && value) {
                                tbody_row.find("."+key).html('<img data-toggle="modal" data-target="#imagemodal_4" src="http://127.0.0.1:8000/storage/'+ value +'" style="width:120px; cursor:pointer;">');
                            } else if (key == 'debited_at' && value) {
                                tbody_row.find("."+key).text(value.substring(0, 19).replace("T", " "))
                            } else {
                                tbody_row.find("."+key).text(value);
                            }
                        });
                        toastr.success("Update Successfully.");
                        $('#editIncomeModal').modal('toggle');
                        $('.update-income')[0].reset()
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
