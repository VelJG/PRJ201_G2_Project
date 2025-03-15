<%-- 
    Document   : imageUpload
    Created on : Mar 12, 2025, 10:20:53 PM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div >
    <form action="<c:url value="/laptop"/>" method="post" enctype="multipart/form-data">
        <input type="file" name="file" id="fileInput" accept="image/*" required />
        <br />
        <img id="previewImage" style="display: block; height: 100px; margin: 0 auto;" alt="Image Preview">
        <br />
        <input type="hidden" name="tempFileName" id="tempFileName" value="" />
        <input type="submit" value="Upload Image" />
    </form>
</div>
<script>
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
</script>