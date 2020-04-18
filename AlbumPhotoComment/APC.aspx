<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="APC.aspx.cs" Inherits="AlbumPhotoComment.Formulario_web1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="row col-md-3" id="dvAlerta" ></div>

<div class="row">
    <div class="col-md-4">
        <h2>Select an Album:</h2>

        <select id ="cboAlbums">
            <option value="">Select one album...</option>
        </select>        
    </div>
    
</div>

<div class="row">
    <div class="col-md-12">
        <h2>Select a Photo:</h2>

        <div  style="overflow:scroll;height:100300px;width:100%;">
            <table id ="tblPhotos" class ="table table-striped" >
            
            </table>                   
      </div>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <h2>Comments of the photo:</h2>

        <table id ="tblPhotos" class ="table table-striped">
            
        </table>        
    </div>
</div>

    <script type="text/javascript">

        // ALBUMS
        $(document).ready(function () {
            $.ajax({
                type: "GET",
                url: "https://jsonplaceholder.typicode.com/albums",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //var datos = $.parseJSON(msg);

                    $(data).each(function () {
                        var option = $(document.createElement('option'));

                        option.text(this.title);
                        option.val(this.id);

                        $("#cboAlbums").append(option);
                    });
                },
                error: function (msg) {
                    $("#dvAlerta > span").text("Error getting albums");
                }
            });

            // PHOTOS
            $("#cboAlbums").change(function () {
                var selectedId = $(this).children("option:selected").val();
                if (selectedId != undefined) {
                    $.ajax({
                        type: "GET",
                        url: "https://jsonplaceholder.typicode.com/photos?albumId=" + selectedId,
                        data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            //var imagesCoun = $(data).length;
                            var col = 0;

                            $(data).each(function () {
                                var row;
                                if (col == 0) {
                                    row = $(document.createElement('tr'));
                                    row.attr("scope", "row");
                                    $("#tblPhotos").append(row);
                                }
                                col++;

                                var cell = $(document.createElement('td'));
                                cell.attr("class", "w-25");

                                var button = $(document.createElement('input'));
                                button.attr("type", "button");
                                button.attr("value", "Comments");
                                button.attr("id", this.albumId);
                                button.attr("class", "btn");

                                var img = $(document.createElement('img'));
                                img.attr("src", this.thumbnailUrl);
                                img.attr("class", "img-fluid img-thumbnail");

                                cell.append(img).append(button);

                                $('#tblPhotos tr:last').append(cell);

                                if (col == 3)
                                    col = 0;
                            });
                        },
                        error: function (msg) {
                            $("#dvAlerta > span").text("Error getting photos");
                        }
                    });
                }
            });



         });
</script>
</asp:Content>
