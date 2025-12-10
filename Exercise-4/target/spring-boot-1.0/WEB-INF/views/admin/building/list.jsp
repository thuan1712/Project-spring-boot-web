<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/09/2025
  Time: 10:23 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>
<c:url var="buildingListURL" value="/admin/building-list"/>
<c:url var="buildingAPI" value="/api/building"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
</head>
<body>


<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="#">Trang chủ</a>
                </li>
                <li class="active">Quản lý tòa nhà</li>
            </ul><!-- /.breadcrumb -->


        </div>

        <div class="page-content">

            <div class="page-header">
                <h1>
                    Danh sách tòa nhà
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div>
            <div id="success-alert-container"
                 style="position: fixed; top: 75px; right: 20px; z-index: 1050; width: 300px;">
                <div id="success-alert" class="alert alert-success" style="display: none;">
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <div class="widget-box">
                        <div class="widget-header ui-sortable-handle">
                            <h5 class="widget-title">Tìm kiếm</h5>

                            <div class="widget-toolbar">
                                <a href="#" data-action="collapse">
                                    <i class="ace-icon fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>

                        <div class="widget-body" style="font-family: 'Times New Roman', Times, serif;">
                            <form:form id="listForm" action="${buildingListURL}" method="get"
                                       modelAttribute="modelSearch">
                                <div class="widget-main" id="listForm">
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-6">
                                                    <label class="name">Tên tòa nhà</label>
                                                        <%--                                                        <input type="text" class="form-control" name="name" value="${modelSearch.name}">--%>
                                                    <form:input class="form-control" path="name"/>

                                                </div>
                                                <div class="col-xs-6">
                                                    <label class="name">Diện tích sàn</label>
                                                        <%--                                                        <input type="number" class="form-control" name="floorArea" value="">--%>
                                                    <form:input class="form-control" path="floorArea"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-sm-2">
                                                    <label class="name">Quận</label>
                                                    <form:select class="form-control" path="district">
                                                        <form:option value="">---Chọn quận---</form:option>
                                                        <form:options items="${districts}"/>

                                                    </form:select>
                                                </div>
                                                <div class="col-xs-5">
                                                    <label class="name">Phường</label>
                                                        <%--                                                        <input type="text" class="form-control" name="ward" value="">--%>
                                                    <form:input class="form-control" path="ward"/>
                                                </div>
                                                <div class="col-xs-5">
                                                    <label class="name">Đường</label>
                                                        <%--                                                        <input type="text" class="form-control" name="street" value="">--%>
                                                    <form:input class="form-control" path="street"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-4">
                                                    <label class="name">Số tầng hầm</label>
                                                        <%--                                                        <input type="text" class="form-control" name="numberOfBasement" value="">--%>
                                                    <form:input class="form-control" path="numberOfBasement"/>
                                                </div>
                                                <div class="col-xs-4">
                                                    <label class="name">Hướng</label>
                                                        <%--                                                        <input type="text" class="form-control" name="direction" value="">--%>
                                                    <form:input class="form-control" path="direction"/>
                                                </div>
                                                <div class="col-xs-4">
                                                    <label class="name">Hạng</label>
                                                        <%--                                                        <input type="number" class="form-control" name="level" value="">--%>
                                                    <form:input class="form-control" path="level"/>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-xs-3">
                                                    <label class="name">Diện tích từ</label>
                                                        <%--                                                        <input type="number" class="form-control" name="areaFrom" value="">--%>
                                                    <form:input class="form-control" path="areaFrom"/>
                                                </div>
                                                <div class="col-xs-3">
                                                    <label class="name">Diện tích đến</label>
                                                        <%--                                                        <input type="number" class="form-control" name="areaTo" value="">--%>
                                                    <form:input class="form-control" path="areaTo"/>
                                                </div>
                                                <div class="col-xs-3">
                                                    <label class="name">Giá thuê từ</label>
                                                        <%--                                                        <input type="number" class="form-control" name="rentPriceFrom" value="">--%>
                                                    <form:input class="form-control" path="rentPriceFrom"/>
                                                </div>
                                                <div class="col-xs-3">
                                                    <label class="name">Giá thuê đến</label>
                                                        <%--                                                        <input type="number" class="form-control" name="rentPriceTo" value="">--%>
                                                    <form:input class="form-control" path="rentPriceTo"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-xs-12">

                                                <div class="col-xs-5">
                                                    <label class="name">Tên quản lý</label>
                                                        <%--                                                        <input type="text" class="form-control" name="managerName" value="">--%>
                                                    <form:input class="form-control" path="managerName"/>
                                                </div>
                                                <div class="col-xs-5">
                                                    <label class="name">SĐT quản lý</label>
                                                        <%--                                                        <input type="text" class="form-control" name="managerPhone" value="">--%>
                                                    <form:input class="form-control" path="managerPhone"/>
                                                </div>
                                                <security:authorize access="hasRole('MANAGER')">
                                                <div class="col-xs-2">
                                                    <label class="name">Nhân viên</label>
                                                    <form:select class="form-control" path="staffId">
                                                        <form:option value="">---Chọn nhân viên---</form:option>
                                                        <form:options items="${staffsList}"/>
                                                    </form:select>
                                                </div>
                                                </security:authorize>
                                            </div>

                                        </div>


                                        <div class="col-xs-12">
                                            <div class="col-xs-6">
                                                <form:checkboxes items="${buildingTypes}"
                                                                 path="typeCode"></form:checkboxes>
                                            </div>
                                        </div>

                                        <div class="col-xs-12">
                                            <div class="col-xs-6">
                                                <button type="button" class="btn btn-xs btn-danger"
                                                        id="btnSearchBuilding">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                         fill="currentColor" class="bi bi-search"
                                                         viewBox="0 0 16 16">
                                                        <path
                                                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0">
                                                        </path>
                                                    </svg>
                                                    Tìm kiếm
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </form:form>

                        </div>

                        <security:authorize access="hasRole('MANAGER')">
                        <div class="pull-right">
                            <a href="/admin/building-edit">
                                <button class="btn-info" title="Thêm tòa nhà">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                        <path
                                                d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                        <path
                                                d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                        <path
                                                d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                    </svg>
                                </button>
                            </a>


                            <button class="btn-danger" title="Xóa tòa nhà" id="btnDeleteBuilding">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-building-dash" viewBox="0 0 16 16">
                                    <path
                                            d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1"/>
                                    <path
                                            d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                    <path
                                            d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                </svg>
                            </button>
                        </div>
                        </security:authorize>
                    </div>
                </div>

            </div><!-- /.page-content -->

            <!-- Bảng danh sách tòa nhà -->
            <%--            <div class="row">--%>
            <%--                <div class="col-xs-12">--%>
            <%--                    <table id="tableList" style="margin: 3em 0 1.5em;"--%>
            <%--                           class="table table-striped table-bordered table-hover">--%>
            <%--                        <thead>--%>
            <%--                        <tr>--%>
            <%--                            <th class="center">--%>
            <%--                                <label class="pos-rel">--%>
            <%--                                    <input type="checkbox" class="ace" name="checkList" value="" id="checkAll">--%>
            <%--                                    <span class="lbl"></span>--%>
            <%--                                </label>--%>
            <%--                            </th>--%>
            <%--                            <th>Tên tòa nhà</th>--%>
            <%--                            <th>Địa chỉ</th>--%>
            <%--                            <th>Số tầng hầm</th>--%>
            <%--                            <th>Tên quản lý</th>--%>
            <%--                            <th>Số điện thoại quản lý</th>--%>
            <%--                            <th>D.Tích sàn</th>--%>
            <%--                            <th>D.Tích trống</th>--%>
            <%--                            <th>D.Tích thuê</th>--%>
            <%--                            <th>Phí mô giới</th>--%>
            <%--                            <th>Thao tác</th>--%>
            <%--                        </tr>--%>
            <%--                        </thead>--%>

            <%--                        <tbody>--%>
            <%--                        <c:forEach var="item" items="${buildingList}">--%>
            <%--                        <tr>--%>
            <%--                            <td>--%>
            <%--                                <label class="pos-rel">--%>
            <%--                                    <input type="checkbox" class="ace" name="checkList" value="${item.id}" data-name="${item.name}">--%>

            <%--                                    <span class="lbl"></span>--%>
            <%--                                </label>--%>
            <%--                            </td>--%>
            <%--                            <td>${item.name}</td>--%>
            <%--                            <td>${item.address}</td>--%>
            <%--                            <td>${item.numberOfBasement}</td>--%>
            <%--                            <td>${item.managerName}</td>--%>
            <%--                            <td>${item.managerPhone}</td>--%>
            <%--                            <td>${item.floorArea}</td>--%>
            <%--                            <td>${item.emptyArea}</td>--%>
            <%--                            <td>${item.rentArea}</td>--%>
            <%--                            <td>${item.brokerageFee}</td>--%>

            <%--                            <td>--%>
            <%--                                <div class="hidden-sm hidden-xs btn-group">--%>
            <%--                                    <button class="btn btn-xs btn-success" title="Giao tòa nhà"--%>
            <%--                                            onclick="assignmentBuilding(${item.id})">--%>
            <%--                                        <i class="ace-icon glyphicon glyphicon-list"></i>--%>
            <%--                                    </button>--%>

            <%--                                    <a class="btn btn-xs btn-info" title="Sửa tòa nhà"--%>
            <%--                                       href="/admin/building-edit-${item.id}">--%>
            <%--                                        <i class="ace-icon fa fa-pencil bigger-120"></i>--%>
            <%--                                    </a>--%>

            <%--                                    <button class="btn btn-xs btn-danger" title="Xóa tòa nhà"--%>
            <%--                                            onclick="deleteBuilding(${item.id}, '${item.name}')">--%>
            <%--                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>--%>
            <%--                                    </button>--%>
            <%--                                </div>--%>
            <%--                            </td>--%>
            <%--                        </tr>--%>

            <%--                        </c:forEach>--%>


            <%--                    </table>--%>
            <%--                </div><!-- /.span -->--%>
            <%--            </div>--%>

            <div class="hr-18 dotted-double"></div>
            <div class="row">
                <div class="col-xs-12">
                    <display:table name="buildings" cellspacing="0" cellpadding="0"
                                   requestURI="${buildingListUrl}" partialList="true" sort="external"
                                   size="${model.totalItems}" defaultsort="1" defaultorder="ascending"
                                   id="tableList" pagesize="${model.maxPageItems}"
                                   class="table table-striped table-bordered table-hover dataTable no-footer"
                                   style="margin: 3em 0 1.5em;">

                        <security:authorize access="hasRole('MANAGER')">
                        <display:column title="<fieldset class='form-group'>
                <input type='checkbox' name='checkAll' class='check-box-element' id='checkAll'>
                </fieldset>" headerClass="center select-cell">
                            <fieldset>
                                <input type="checkbox"
                                       name="checkList"
                                       value="${tableList.id}"
                                       id="checkbox_${tableList.id}"
                                       class="check-box-element"
                                       data-name="${tableList.name}"/>
                            </fieldset>
                        </display:column>
                        </security:authorize>
                        <display:column headerClass="text-left" property="name" title="Tên sản phẩm"/>
                        <display:column headerClass="text-left" property="address" title="Địa chỉ"/>
                        <display:column headerClass="text-left" property="numberOfBasement" title="Số tầng hầm"/>
                        <display:column headerClass="text-left" property="managerName" title="Tên quản lý"/>
                        <display:column headerClass="text-left" property="managerPhone" title="Số điện thoại"/>
                        <display:column headerClass="text-left" property="floorArea" title="D.T sàn"/>
                        <display:column headerClass="text-left" property="emptyArea" title="D.T trống"/>
                        <display:column headerClass="text-left" property="rentPrice" title="Giá thuê"/>
                        <display:column headerClass="text-left" property="serviceFee" title="Phí dịch vụ"/>
                        <display:column headerClass="text-left" property="brokerageFee" title="Phí MG"/>

                        <display:column headerClass="text-left" title="Thao tác">
                            <div class="hidden-sm hidden-xs btn-group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-success" data-toggle="tooltip" title="Giao tòa nhà"
                                            onclick="assingmentBuilding(${tableList.id})">
                                        <i class="ace-icon fa fa-bars bigger-120"></i>
                                    </button>
                                </security:authorize>
                                <a class="btn btn-xs btn-info" data-toggle="tooltip"
                                   title="Sửa tòa nhà"
                                   href="<c:url value='/admin/building-edit-${tableList.id}'/>">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </a>
                                <security:authorize access="hasRole('MANAGER')">
                                    <button class="btn btn-xs btn-danger" data-toggle="tooltip" title="Xóa tòa nhà"
                                            onclick="deleteBuilding(${tableList.id}, '${tableList.name}')">
                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                    </button>
                                </security:authorize>
                            </div>
                        </display:column>
                    </display:table>
                </div>
            </div>

        </div>
    </div><!-- /.main-content -->


    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div><!-- /.main-container -->
</div>


<div class="modal fade" id="assginmentBuildingModal" role="dialog"
     style="font-family: 'Times New Roman', Times, serif;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-bordered table-hover" id="staffList">
                    <thead>
                    <tr>
                        <th class="text-center">Chọn</th>
                        <th>Tên Nhân Viên</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
                <input type="hidden" id="buildingId" name="Building" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="btnassginmentBuilding">Giao tòa nhà</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/jquery.2.1.1.min.js"></script>

<script>
    function assingmentBuilding(buildingId) {
        // Gán giá trị buildingId vào input hidden
        $('#buildingId').val(buildingId);
        loadStaff(buildingId);
        // Mở modal
        $('#assginmentBuildingModal').modal('show');
    }

    function loadStaff(buildingId) {
        $.ajax({
            type: "GET",
            url: `${buildingAPI}/` + buildingId + '/staffs',
            // data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "JSON",
            success: function (response) {
                var row = '';
                $.each(response.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="text-center"><input type="checkbox" value=' + item.staffId + ' id="checkbox_' + item.staffId + '" class="check-box-element"' + item.checked + '/></td>';
                    row += '<td class="text-center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);
                console.info("Success");
            },
            error: function (response) {
                console.log("failed");
                console.log(response);
            }
        });
    }

    $('#btnassginmentBuilding').click(function (e) {
        e.preventDefault();
        var data = {};
        data['buildingId'] = $('#buildingId').val();
        var staffs = $('#staffList').find('tbody input[type = checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['staffs'] = staffs;
        // if (data['staffs'] != '') {
        //     assingment(data);
        // }
        assingment(data);
        console.log("OK");
    });

    function assingment(data) {
        $.ajax({
            url: `${buildingAPI}/assignments`,
            type: "PUT",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function (response) {
                window.location.href = "<c:url value='/admin/building-list?message=update_success'/>";

                console.info("Succcess");
            },
            error: function (response) {
                console.info("Giao Không Thành Công!")
                window.location.href = "<c:url value='/admin/building-list?message=error'/>";
                console.log(response);
            }
        });
    }


    function showAlert(message) {
        // Cập nhật nội dung và hiển thị Alert
        $('#success-alert').html('<button type="button" class="close" data-dismiss="alert"><i class="ace-icon fa fa-times"></i></button><strong>Thành công!</strong> ' + message);

        // Hiện thanh thông báo
        $('#success-alert').fadeIn();

        // Thiết lập tự động biến mất sau 3 giây
        setTimeout(function () {
            $('#success-alert').fadeOut();
        }, 3000);
    }

    // Logic kiểm tra message sau khi tải trang
    <c:if test="${not empty param.message}">
    <c:if test="${param.message == 'addorupdate_success'}">
    $(document).ready(function () {
        // Lấy tham số action
        var actionType = "${param.action}";
        var message = "";

        // Phân biệt thông báo dựa trên action
        if (actionType === "CREATED") {
            message = "Thêm tòa nhà mới thành công.";
        } else if (actionType === "UPDATED") {
            message = "Cập nhật tòa nhà thành công.";
        } else {
            message = "Thao tác tòa nhà thành công."; // Mặc định
        }

        showAlert(message);
    });
    </c:if>

    <c:if test="${param.message == 'update_success'}">
    $(document).ready(function () {
        // Kích hoạt hàm hiển thị alert khi giao thành công
        showAlert("Giao tòa nhà thành công.");
    });
    </c:if>

    <c:if test="${param.message == 'delete_success'}">
    $(document).ready(function () {
        // Kích hoạt hàm hiển thị alert khi xóa thành công
        showAlert("Xóa tòa nhà thành công.");
    });
    </c:if>
    </c:if>



    $('#btnSearchBuilding').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();
    })


    function deleteBuilding(id, name) {
        var buildingIds = [id];
        var buildingNames = [name];
        deleteBuildings(buildingIds, buildingNames);
    }


    $('#btnDeleteBuilding').click(function (e) {
        e.preventDefault();

        var selectedCheckboxes = $('#tableList').find('tbody input[type = checkbox][name = checkList]:checked');

        var buildingIds = selectedCheckboxes.map(function () {
            return $(this).val();
        }).get();

        var buildingNames = selectedCheckboxes.map(function () {
            // Lấy tên tòa nhà từ thuộc tính data-name
            return $(this).data('name');
        }).get();

        if (buildingIds.length === 0) {
            alert("Vui lòng chọn ít nhất một tòa nhà để xóa.");
            return;
        }

        deleteBuildings(buildingIds, buildingNames);
    });

    function deleteBuildings(ids, names) {

        var namesString = names.join(', ');

        var confirmDelete = confirm("Bạn có chắc chắn muốn xóa những tòa nhà sau: \n" + namesString + "?");

        if (confirmDelete) {

            $.ajax({
                type: "DELETE",
                // Gửi các ID dưới dạng chuỗi ngăn cách bằng dấu phẩy
                url: "${buildingAPI}/" + ids.join(','),
                contentType: "application/json",
                success: function (respond) {
                    alert("Xóa tòa nhà thành công!");
                    window.location.href = "<c:url value='/admin/building-list?message=delete_success'/>";
                },
                error: function (respond) {
                    alert("Xóa tòa nhà không thành công!");
                    console.log(respond);
                    window.location.href = "<c:url value='/admin/building-list?message=error'/>";
                }
            });
        }
    }

    $(document).ready(function () {
        $('#checkAll').click(function () {

            var isChecked = this.checked;

            $('input[name="checkList"]').prop('checked', isChecked);
        });
    });
</script>

</body>
</html>

