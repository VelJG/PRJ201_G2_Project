<%-- 
    Document   : imageUpload
    Created on : Mar 12, 2025, 10:20:53 PM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="laptop-manage-container d-flex justify-content-center">
    <div class="form-wrapper" style="max-width: 500px; width: 100%;">
        <div class="header-bar d-flex justify-content-center">
            <h2 class="text-white text-center">Upload Laptop Image</h2>
        </div>

        <form action="<c:url value='/laptop'/>" method="post" enctype="multipart/form-data" class="text-center">
            <!-- File Input -->
            <div class="mb-3">
                <label class="form-label text-white">Select Image:</label>
                <input type="file" name="file" id="fileInput" accept="image/*" required class="form-control"/>
            </div>

            <!-- Image Preview -->
            <div class="mb-3 d-flex justify-content-center">
                <img id="previewImage" style="display: none; height: 150px; width: auto; 
                     border: 3px solid white; border-radius: 10px; padding: 5px;" alt="Image Preview">
            </div>

            <!-- Hidden Input -->
            <input type="hidden" name="tempFileName" id="tempFileName" value="">

            <!-- Buttons -->
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-upload"></i> Upload
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById("fileInput").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const previewImage = document.getElementById("previewImage");
                previewImage.src = e.target.result;
                previewImage.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });

    function clearPreview() {
        document.getElementById("previewImage").style.display = "none";
        document.getElementById("fileInput").value = "";
    }
</script>
