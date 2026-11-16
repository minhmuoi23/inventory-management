<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="right_col" role="main">
	<div class="">

		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Danh sách sản phẩm</h2>

					<div class="clearfix"></div>
				</div>


				<div class="x_content">
					<a href="<c:url value="/product-info/add"/>" class="btn btn-app"><i class="fa fa-plus"></i>Thêm sản phẩm</a>
					<div class="container" style="padding: 50px;">
						<form:form modelAttribute="searchForm" cssClass="form-horizontal form-label-left" servletRelativeAction="/product-info/list/1" method="POST">
							<div class="form-group">
								<label for="description" class="control-label col-md-3 col-sm-3 col-xs-12">ID</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="id" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="code">Mã sản phẩm </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="code" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Tên sản phẩm </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="name" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="supplierId">Nhà cung cấp </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="supplierId" cssClass="form-control">
										<form:options items="${mapSupplier}" />
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="cateId">Loại hàng </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="cateId" cssClass="form-control">
										<form:options items="${mapCategory}" />
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
									<button type="submit" class="btn btn-success">Tìm kiếm</button>
								</div>
							</div>

						</form:form>
					</div>

					<div class="table-responsive">
						<table class="table table-striped jambo_table bulk_action">
							<thead>
								<tr class="headings">
									<th class="column-title">STT</th>
									<th class="column-title">Id</th>
									<th class="column-title">Mã sản phẩm</th>
									<th class="column-title">Tên sản phẩm</th>
									<th class="column-title">Loại hàng</th>
									<th class="column-title">Nhà cung cấp</th>
									<th class="column-title">Ảnh sản phẩm</th>
									<th class="column-title no-link last text-center" colspan="3"><span class="nobr">Hành động</span></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${products}" var="product" varStatus="loop">

									<c:choose>
										<c:when test="${loop.index%2==0 }">
											<tr class="even pointer">
										</c:when>
										<c:otherwise>
											<tr class="odd pointer">
										</c:otherwise>
									</c:choose>
									<td class=" ">${pageInfo.getOffset()+loop.index+1}</td>
									<td class=" ">${product.id }</td>
									<td class=" ">${product.code }</td>
									<td class=" ">${product.name }</td>
									<td class=" ">${product.category.name }</td>
									<td class=" ">${product.supplier.name }</td>
									<td class=" "><img src="<c:url value="${product.imgUrl}"/>" width="100px" height="100px"/></td>
									<td class="text-center"><a href="<c:url value="/product-info/view/${product.id }"/>" class="btn btn-round btn-default">Xem</a></td>
									<td class="text-center"><a href="<c:url value="/product-info/edit/${product.id }"/>" class="btn btn-round btn-primary">Sửa</a></td>
									<td class="text-center"><a href="javascript:void(0);" onclick="confirmDelete(${product.id});" class="btn btn-round btn-danger">Xoá</a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
						<jsp:include page="../layout/paging.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	 function confirmDelete(id){
		 if(confirm('Bạn có muốn xoá sản phẩm này không?')){
			 window.location.href = '<c:url value="/product-info/delete/"/>'+id;
		 }
	 }
	 function gotoPage(page){
		 $('#searchForm').attr('action','<c:url value="/product-info/list/"/>'+page);
		 $('#searchForm').submit();
	 }
	 $(document).ready(function(){
		 processMessage();
	 });
	 function processMessage(){
		 var msgSuccess = '${msgSuccess}';
		 var msgError = '${msgError}';
		 if(msgSuccess){
			 new PNotify({
                 title : ' Thành công',
                 text: msgSuccess,
                 type: 'success',
                 styling: 'bootstrap3'
             });
		 }
		 if(msgError){
			 new PNotify({
                 title : ' Lỗi',
                 text: msgError,
                 type: 'error',
                 styling: 'bootstrap3'
             });
		 }
	 }
	
	
</script>	