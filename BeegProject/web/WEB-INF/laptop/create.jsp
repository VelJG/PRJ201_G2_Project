<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2 style="text-align: center; color:red;">Create Laptop</h2>
<div  class="row" style="display:block; text-align: center;"> 
    <div >
<!--       <form action="<c:url value="/laptop"/>" method="post" enctype="multipart/form-data">
            <input type="file" name="file" id="fileInput" accept="image/*" required />
            <br />
            <img id="previewImage" style="display: block; height: 100px; margin: 0 auto;" alt="Image Preview">
            <br />
            <input type="hidden" name="tempFileName" id="tempFileName" value="" />
            <input type="submit" value="Upload Image" />
        </form>-->

        
    </div>
    <div style="display:block;  margin:0; padding:10px">
        <form action="<c:url value="/laptop/create_handler.do"/>">

            Brand: <br>
            <input type="text" name="brand" value="${param.brand!=null?param.brand:laptop.brand}"><br>
            Description:<br>
            <input type="text" name="description" value="${param.description!=null?param.description:laptop.description}"><br>
            Price:<br>
            <input type="number" name="price" value="${param.price!=null?param.price:laptop.formattedPrice}" min="0"> đ<br>
            <button type="submit" value="create" name="op">Create</button>
            <button type="submit" value="cancel" name="op">Cancel</button>
        </form>
    </div>
</div>
<!--            <script>
            document.getElementById("fileInput").addEventListener("change", function (event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById("previewImage").src = e.target.result;
                        document.getElementById("previewImage").style.display = "block";
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>-->
