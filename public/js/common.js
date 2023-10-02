var urlParams = new URLSearchParams(window.location.search)
var sort = urlParams.get('sort')
var filter_post = urlParams.get('filter_post')
var filter_type = urlParams.get('filter_type')
var admin_wallet_address;
var api=(function(){

    url="http://127.0.0.1:8000/admin/"

    return function(end) {return url+end;};
})();

function reroute(url){
    window.location.href=url;
}

function capitalize(str) {
    strVal = '';
    str = str.split(' ');
    for (var chr = 0; chr < str.length; chr++) {
      strVal += str[chr].substring(0, 1).toUpperCase() + str[chr].substring(1, str[chr].length) + ' '
    }
    return strVal
}

 //delete record
 function delete_record(page, delete_id){
    $.ajax({
        url:api(page + "/ajax_delete"),
        type:"POST",
        dataType: "JSON",
        data: {
            id: delete_id
        },
        success:function(data){
            // console.log("pass");
            // console.log(data);
            if(data.success) {
                $('#delete_modal').modal('toggle');
                $("tr[row_id='"+ delete_id +"']").remove()
                toastr.success("Deleted Successfully.");
            } else {
                toastr.warning(data.message);
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

//delete bulk records
function delete_bulk_records(page, bulk_delete){
    $.ajax({
        url:api(page + "/ajax_bulk_delete"),
        type:"POST",
        dataType: "JSON",
        data: {
            delete_array: bulk_delete
        },
        success:function(data){
            // console.log("pass");
            // console.log(data);
            if(data.success) {
                $('#bulk_delete_modal').modal('toggle');
                bulk_delete.forEach(function(id) {
                    $("tr[row_id='"+ id +"']").remove()
                });
                bulk_delete_array = []
                $('th').find("input[type='checkbox']").prop('checked', false)
                toastr.success("Deleted Successfully.");
            } else {
                toastr.warning(data.message);
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

function select2Customize(add_modal_id, edit_modal_id) {
    $("#select-drop-down-add").select2({ dropdownParent: "#"+add_modal_id })
    $("#select-drop-down-edit").select2({ dropdownParent: "#"+edit_modal_id });
    $(".select2").addClass("form-control")
    $(".select2").attr("style", "width:100%;")
    $(".select2-selection__rendered").attr("style", "line-height: unset; padding-left: 5px;")
    $(".select2-selection--single").attr("style", "border: 0px; height: auto; padding: 0px;")
}

$(document).ready(function () {
    if(sort){
        $("#sort_field").val(sort)
    }
    if(filter_post){
        $("#filter_post_field").val(filter_post)
    }
    if(filter_type){
        $("#filter_type_field").val(filter_type)
    }
    $(".app-footer").hide()

    $("#pending-tbody").on("click", ".delete", function(){
        delete_id = $(this).attr("delete_id");
    })
    $(".bulk-delete").on("click", function(){
        if(bulk_delete_array.length > 0){
            $('#bulk_delete_modal').modal('toggle');
        } else {
            toastr.warning("You haven't selected anything to delete")
        }
    })
    $("input[check_type='all']").on("click", function(){
        var all_checked = this.checked
        bulk_delete_array = []
        if(all_checked) {
            $(".table-row").find("input[type='checkbox']").prop('checked', true)
            $(".table-row").find("input[type='checkbox']").each(function () {
                bulk_delete_array.push($(this).attr("check_type"))
            });
        } else {
            $(".table-row").find("input[type='checkbox']").prop('checked', false)
        }
    })    
    $("#pending-tbody").on("click", "input[type='checkbox']", function(){
        var selected_id = parseInt($(this).attr("check_type"))
        if(this.checked) {
            bulk_delete_array.push(parseInt(selected_id))
        } else {
            bulk_delete_array.splice(bulk_delete_array.indexOf(selected_id), 1);
        }
    })
    $('#pending-tbody').on('click', '.attachment', function() {
        $('#imagemodal_4').find('img').attr('src', $(this).find('img').attr('src'))
    })
});