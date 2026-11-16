<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="right_col" role="main">
	<div class="">

		<div class="clearfix"></div>
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Danh sách vai trò</h2>

					<div class="clearfix"></div>
				</div>


				<div class="x_content">
					<a href="<c:url value="/role/add"/>" class="btn btn-app"><i class="fa fa-plus"></i>Thêm vai trò</a>
					<div class="container" style="padding: 50px;">
						<form:form modelAttribute="searchForm" cssClass="form-horizontal form-label-left" servletRelativeAction="/role/list/1" method="POST">
					

						</form:form>
					</div>

					<div class="table-responsive">
						<table class="table table-striped jambo_table bulk_action">
							<thead>
								<tr class="headings">
									<th class="column-title">STT</th>
									<th class="column-title">Id</th>
									<th class="column-title">Tên vai trò</th>
									<th class="column-title">Mo tả</th>
									<th class="column-title no-link last text-center" colspan="3"><span class="nobr">Hành động</span></th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${roles}" var="role" varStatus="loop">

									<c:choose>
										<c:when test="${loop.index%2==0 }">
											<tr class="even pointer">
										</c:when>
										<c:otherwise>
											<tr class="odd pointer">
										</c:otherwise>
									</c:choose>
									<td class=" ">${pageInfo.getOffset()+loop.index+1}</td>
									<td class=" ">${role.id }</td>
									<td class=" ">${role.roleName }</td>
									<td class=" ">${role.description }</td>
									<td class="text-center"><a href="<c:url value="/role/view/${role.id }"/>" class="btn btn-round btn-default">Xem</a></td>
									<td class="text-center"><a href="<c:url value="/role/edit/${role.id }"/>" class="btn btn-round btn-primary">Sửa</a></td>
									<td class="text-center"><a href="javascript:void(0);" onclick="confirmDelete(${role.id});" class="btn btn-round btn-danger">Xoá</a></td>
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
		 if(confirm('Bạn có muốn xoá vai trò này?')){
			 window.location.href = '<c:url value="/role/delete/"/>'+id;
		 }
	 }
	 function gotoPage(page){
		 $('#searchForm').attr('action','<c:url value="/role/list/"/>'+page);
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