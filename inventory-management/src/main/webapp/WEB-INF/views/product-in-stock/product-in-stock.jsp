<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<style>
	.sort-wrapper {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		gap: 12px;
		margin-bottom: 15px;
	}
	.sort-label {
		color: #999;
		font-size: 14px;
	}
	.sort-pill-btn {
		background: #fff;
		border: 1px solid #d9d9d9;
		border-radius: 20px;
		padding: 6px 12px;
		font-size: 14px;
		line-height: 1.42857;
		color: #333;
	}
	.sort-pill-btn:hover,
	.sort-pill-btn:focus,
	.sort-pill-btn:active {
		background: #fff;
		border-color: #aaa;
		color: #333;
		box-shadow: none;
	}
	.sort-wrapper .dropdown-menu {
		font-size: 14px;
	}
	.sort-wrapper .dropdown-menu > li > a {
		padding: 6px 12px;
	}
</style>
<div class="right_col" role="main">
	<div class="">

		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Sản phẩm trong kho</h2>

					<div class="clearfix"></div>
				</div>


				<div class="x_content">
					<div class="container" style="padding: 50px;">
						<form:form modelAttribute="searchForm" cssClass="form-horizontal form-label-left" servletRelativeAction="/product-in-stock/list/1" method="POST">
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="code">Mã sản phẩm </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="productInfo.code" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="code">Loại hàng</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="productInfo.category.id" cssClass="form-control">
										<form:options items="${mapCategory}" />
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">Tên sản phẩm </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="productInfo.name" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>

							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="supplier">Nhà cung cấp </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="productInfo.supplier.id" cssClass="form-control">
										<form:options items="${mapSupplier}" />
									</form:select>
								</div>
							</div>

							<form:hidden path="sortBy" />
							<form:hidden path="sortDir" />

							<div class="form-group">
								<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
									<button type="submit" class="btn btn-success">Tìm kiếm</button>
								</div>
							</div>

						</form:form>
					</div>

					<div class="sort-wrapper">
						<span class="sort-label">Sắp xếp</span>
						<div class="dropdown">
							<button class="btn sort-pill-btn dropdown-toggle" type="button" id="sortDropdownBtn" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span id="sortDropdownLabel">
									<c:choose>
										<c:when test="${searchForm.sortBy=='price' && searchForm.sortDir=='desc'}">Giá giảm dần</c:when>
										<c:when test="${searchForm.sortBy=='price'}">Giá tăng dần</c:when>
										<c:when test="${searchForm.sortBy=='qty' && searchForm.sortDir=='desc'}">Số lượng giảm dần</c:when>
										<c:when test="${searchForm.sortBy=='qty'}">Số lượng tăng dần</c:when>
										<c:otherwise>Mặc định</c:otherwise>
									</c:choose>
								</span>
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu dropdown-menu-right" aria-labelledby="sortDropdownBtn">
								<li><a href="javascript:void(0);" onclick="applySort('','','Mặc định');">Mặc định</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="javascript:void(0);" onclick="applySort('price','asc','Giá tăng dần');">Giá tăng dần</a></li>
								<li><a href="javascript:void(0);" onclick="applySort('price','desc','Giá giảm dần');">Giá giảm dần</a></li>
								<li><a href="javascript:void(0);" onclick="applySort('qty','asc','Số lượng tăng dần');">Số lượng tăng dần</a></li>
								<li><a href="javascript:void(0);" onclick="applySort('qty','desc','Số lượng giảm dần');">Số lượng giảm dần</a></li>
							</ul>
						</div>
					</div>

					<div class="table-responsive">
						<table class="table table-striped jambo_table bulk_action">
							<thead>
								<tr class="headings">
									<th class="column-title">STT</th>
									<th class="column-title">Loại hàng</th>
									<th class="column-title">Mã sản phẩm</th>
									<th class="column-title">Tên sản phẩm</th>
									<th class="column-title">Nhà cung cấp</th>
									<th class="column-title">Ảnh sản phẩm</th>
									<th class="column-title">Số lượng</th>
									<th class="column-title">Giá trung bình</th>
									<th class="column-title">Thao tác</th>
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
									<td class=" ">${product.productInfo.category.name }</td>
									<td class=" ">${product.productInfo.code }</td>
									<td class=" ">${product.productInfo.name }</td>
									<td class=" ">${product.productInfo.supplier.name }</td>
									<td class=" "><img src="<c:url value="${product.productInfo.imgUrl}"/>" width="100px" height="100px"/></td>
									<td class="">${product.qty }</td>
									<td class="">${product.price }</td>
									<td class="">
										<a href="<c:url value="/goods-issue/add?productId=${product.productInfo.id}"/>" class="btn btn-warning btn-xs" title="Tạo phiếu xuất kho cho sản phẩm này">
											<i class="fa fa-sign-out"></i> Xuất hàng
										</a>
									</td>
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
	 function gotoPage(page){
		 $('#searchForm').attr('action','<c:url value="/product-in-stock/list/"/>'+page);
		 $('#searchForm').submit();
	 }
	 function applySort(sortBy, sortDir, label){
		 $('#sortBy').val(sortBy);
		 $('#sortDir').val(sortDir);
		 $('#sortDropdownLabel').text(label);
		 gotoPage(1);
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