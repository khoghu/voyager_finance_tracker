<!-- add modal -->
<div class="modal fade" id="newStaticExpenseModal" tabindex="-1" role="dialog" aria-labelledby="newStaticExpenseModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="display:flex;">
                <h3 class="modal-title" id="exampleModalLabel" style="width: 100%">Add Static Expense</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" style="margin-top: 0px;font-size: 30px;">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="new-static-expense">
                    <div class="form-group">
                        <label for="group" class="col-form-label">Group:</label>
                        <select type="text" id="select-drop-down-add" class="form-control" name="group_id" required>
                            <option value="" disabled selected>Select Finance Group</option>
                            @foreach($groups as $group)
                                <option value="{{$group->id}}">{{ $group->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="title" class="col-form-label">Title:</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-form-label">Description:</label>
                        <input type="text" class="form-control" name="description">
                    </div>
                    <div class="form-group">
                        <label for="amount" class="col-form-label">Amount:</label>
                        <input type="number" step="0.01" pattern="^\d+(\.\d{2})?$" title="Please enter a number with two decimal places" class="form-control" name="amount" required>
                    </div>
                    <div class="form-group">
                        <label for="credit_day_per_month" class="col-form-label">Credit Day Per Month:</label>
                        <input type="number" class="form-control" name="credit_day_per_month" min=1 max=31  required>
                    </div>
                    <div class="form-group" style="text-align: center">
                        <input type="submit" value="Submit" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- edit modal -->
<div class="modal fade" id="editStaticExpenseModal" tabindex="-1" role="dialog" aria-labelledby="editStaticExpenseModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" style="display:flex;">
                <h3 class="modal-title" id="exampleModalLabel" style="width: 100%">Update Static Expense</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true" style="margin-top: 0px;font-size: 30px;">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="update-static-expense">
                    <input type="hidden" name="id">
                    <div class="form-group">
                        <label for="group" class="col-form-label">Group:</label>
                        <select type="text" id="select-drop-down-edit" class="form-control" name="group_id" required>
                            <option value="" disabled selected>Select Finance Group</option>
                            @foreach($groups as $group)
                                <option value="{{$group->id}}">{{ $group->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="title" class="col-form-label">Title:</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="description" class="col-form-label">Description:</label>
                        <input type="text" class="form-control" name="description">
                    </div>
                    <div class="form-group">
                        <label for="amount" class="col-form-label">Amount:</label>
                        <input type="number" step="0.01" pattern="^\d+(\.\d{2})?$" title="Please enter a number with two decimal places" class="form-control" name="amount" required>
                    </div>
                    <div class="form-group">
                        <label for="credit_day_per_month" class="col-form-label">Credit Day Per Month:</label>
                        <input type="number" class="form-control" name="credit_day_per_month" min=1 max=31  required>
                    </div>
                    <div class="form-group" style="text-align: center">
                        <input type="submit" value="Submit" class="btn btn-primary">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- delete modal -->
<div class="modal modal-danger fade" tabindex="-1" id="delete_modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><i class="voyager-trash" style="margin-right:10px;"></i>Are you sure you want to delete this static expense?</h4>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-right delete_confirm">Delete Confirm</button>
                <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- bulk delete modal -->
<div class="modal modal-danger fade" tabindex="-1" id="bulk_delete_modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title"><i class="voyager-trash" style="margin-right:10px;"></i>Are you sure you want to delete these static expenses?</h4>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger pull-right bulk_delete_confirm">Delete Confirm</button>
                <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
</div>