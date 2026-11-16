<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script> 
<style>
.price{
	font-size: 14px;
}
</style>
<div class="right_col" role="main">
	<div class="">

		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Danh Sách Phiếu Nhập Kho</h2>

					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<a href="<c:url value="/goods-receipt/add"/>" class="btn btn-app"><i class="fa fa-plus"></i>Thêm mới</a>
					<a href="<c:url value="/goods-receipt/export"/>" class="btn btn-app"><i class="fa fa-cloud-download"></i>Xuất báo cáo</a>
					<div class="container" style="padding: 50px;">
						<form:form modelAttribute="searchForm" cssClass="form-horizontal form-label-left" servletRelativeAction="/goods-receipt/list/1" method="POST">
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="code">Mã phiếu </label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:input path="code" cssClass="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="fromDate">Từ ngày</label>
								<div class="col-md-6 col-sm-6 col-xs-12 ">
									<div class="input-group date" id='fromDatePicker'>
										<form:input path="fromDate" class="form-control" />
										<span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="toDate">Đến ngày </label>
								<div class="col-md-6 col-sm-6 col-xs-12 ">
									<div class="input-group date" id='toDatePicker'>
										<form:input path="toDate" class="form-control" />
										<span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>

								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="productId">Sản phẩm</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="productId" cssClass="form-control">
										<form:option value="">-- Tất cả sản phẩm --</form:option>
										<form:options items="${mapProduct}" />
									</form:select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12" for="createdById">Người nhập</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<form:select path="createdById" cssClass="form-control">
										<form:option value="">-- Tất cả --</form:option>
										<form:options items="${mapUser}" />
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
									<th class="column-title">#</th>
									<th class="column-title">Mã phiếu</th>
									<th class="column-title">Số lượng</th>
									<th class="column-title">Đơn giá</th>
									<th class="column-title">Sản phẩm</th>
									<th class="column-title">Người nhập</th>
									<th class="column-title">Ngày cập nhật</th>
									<th class="column-title no-link last text-center" colspan="3"><span class="nobr">Thao tác</span></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${invoices}" var="invoice" varStatus="loop">

									<c:choose>
										<c:when test="${loop.index%2==0 }">
											<tr class="even pointer">
										</c:when>
										<c:otherwise>
											<tr class="odd pointer">
										</c:otherwise>
									</c:choose>
									<td class=" ">${pageInfo.getOffset()+loop.index+1}</td>
									<td class=" ">${invoice.code }</td>
									<td class=" ">${invoice.qty }</td>
									<td class="price">${invoice.price }</td>
									<td class=" ">${invoice.productInfo.name }</td>
									<td class=" ">${not empty invoice.createdBy ? invoice.createdBy.name : '-'}</td>
									<td class="date">${invoice.updateDate}</td>

									<td class="text-center"><a href="<c:url value="/goods-receipt/view/${invoice.id }"/>" class="btn btn-round btn-default">Xem</a></td>
									<td class="text-center"><a href="<c:url value="/goods-receipt/edit/${invoice.id }"/>" class="btn btn-round btn-primary">Sửa</a></td>
									<td class="text-center"><a href="javascript:void(0);" onclick="confirmDelete(${invoice.id});" class="btn btn-round btn-danger">Xóa</a></td>
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
		 if(confirm('Bạn có muốn xóa bản ghi này không?')){
			 window.location.href = '<c:url value="/goods-receipt/delete/"/>'+id;
		 }
	 }
	 function gotoPage(page){
		 $('#searchForm').attr('action','<c:url value="/goods-receipt/list/"/>'+page);
		 $('#searchForm').submit();
	 }
	 $(document).ready(function(){
		 processMessage();
		 $('#fromDatePicker').datetimepicker({
			 format : 'YYYY-MM-DD HH:mm:ss'
		 });
		 $('#toDatePicker').datetimepicker({
			 format : 'YYYY-MM-DD HH:mm:ss'
		 })
		  $('.price').each(function(){ 
			 $(this).text(numeral($(this).text()).format('0,0'));
		 }) 
	 });
	 function processMessage(){
		 var msgSuccess = '${msgSuccess}';
		 var msgError = '${msgError}';
		 if(msgSuccess){
			 new PNotify({
                 title: ' Thành công',
                 text: msgSuccess,
                 type: 'success',
                 styling: 'bootstrap3'
             });
		 }
		 if(msgError){
			 new PNotify({
                 title: ' Lỗi',
                 text: msgError,
                 type: 'error',
                 styling: 'bootstrap3'
             });
		 }
	 }
	
	
</script>