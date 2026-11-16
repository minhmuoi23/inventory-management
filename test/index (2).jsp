<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="right_col" role="main">
<div class="page-title"><div class="title_left"><h3>Dashboard thống kê kho hàng</h3></div></div><div class="clearfix"></div>
<div class="row top_tiles">
<div class="col-md-3 col-sm-6 col-xs-12"><div class="tile-stats"><div class="icon"><i class="fa fa-cubes"></i></div><div class="count">${dashboard.totalProducts}</div><h3>Sản phẩm</h3><p>Tổng sản phẩm đang hoạt động</p></div></div>
<div class="col-md-3 col-sm-6 col-xs-12"><div class="tile-stats"><div class="icon"><i class="fa fa-tags"></i></div><div class="count">${dashboard.totalCategories}</div><h3>Danh mục</h3><p>Tổng danh mục đang hoạt động</p></div></div>
<div class="col-md-3 col-sm-6 col-xs-12"><div class="tile-stats"><div class="icon"><i class="fa fa-sign-in"></i></div><div class="count">${dashboard.totalReceipts}</div><h3>Phiếu nhập</h3><p>Tổng số phiếu nhập kho</p></div></div>
<div class="col-md-3 col-sm-6 col-xs-12"><div class="tile-stats"><div class="icon"><i class="fa fa-sign-out"></i></div><div class="count">${dashboard.totalIssues}</div><h3>Phiếu xuất</h3><p>Tổng số phiếu xuất kho</p></div></div>
</div>
<div class="row"><div class="col-md-8 col-sm-12"><div class="x_panel"><div class="x_title"><h2>Nhập - xuất kho 12 tháng gần nhất</h2><div class="clearfix"></div></div><div class="x_content"><canvas id="inventoryFlowChart" height="100"></canvas></div></div></div>
<div class="col-md-4 col-sm-12"><div class="x_panel"><div class="x_title"><h2>Tổng tồn kho</h2><div class="clearfix"></div></div><div class="x_content text-center"><h1 style="font-size:48px;margin:20px 0 10px"><i class="fa fa-archive"></i> ${dashboard.totalStock}</h1><p>Số lượng sản phẩm hiện có trong kho</p><hr/><h4>Giá trị tồn kho</h4><h2><fmt:formatNumber value="${dashboard.stockValue}" type="number" maxFractionDigits="0"/> VNĐ</h2><hr/><h4>Doanh thu</h4><h2 style="color:#26A69A"><fmt:formatNumber value="${dashboard.totalRevenue}" type="number" maxFractionDigits="0"/> VNĐ</h2><hr/><h4>Lợi nhuận</h4><h2 style="color:${dashboard.totalProfit >= 0 ? '#26A69A' : '#EF5350'}"><fmt:formatNumber value="${dashboard.totalProfit}" type="number" maxFractionDigits="0"/> VNĐ</h2></div></div></div></div>
<div class="row"><div class="col-md-5 col-sm-12"><div class="x_panel"><div class="x_title"><h2>Tồn kho theo danh mục</h2><div class="clearfix"></div></div><div class="x_content"><canvas id="categoryStockChart" height="180"></canvas></div></div></div>
<div class="col-md-7 col-sm-12"><div class="x_panel"><div class="x_title"><h2>Top 5 sản phẩm tồn kho nhiều nhất</h2><div class="clearfix"></div></div><div class="x_content"><table class="table table-striped jambo_table"><thead><tr><th>#</th><th>Mã SP</th><th>Sản phẩm</th><th>Danh mục</th><th>Tồn</th></tr></thead><tbody>
<c:forEach items="${dashboard.topStockProducts}" var="item" varStatus="s"><tr><td>${s.count}</td><td>${item.code}</td><td>${item.name}</td><td>${item.categoryName}</td><td><strong>${item.qty}</strong></td></tr></c:forEach>
<c:if test="${empty dashboard.topStockProducts}"><tr><td colspan="5" class="text-center">Chưa có dữ liệu tồn kho</td></tr></c:if></tbody></table></div></div></div></div>
<div class="row"><div class="col-md-12"><div class="x_panel"><div class="x_title"><h2><i class="fa fa-warning"></i> Cảnh báo sản phẩm sắp hết hàng (tồn kho &lt;= 10)</h2><div class="clearfix"></div></div><div class="x_content"><table class="table table-striped jambo_table"><thead><tr><th>#</th><th>Mã SP</th><th>Sản phẩm</th><th>Danh mục</th><th>Số lượng tồn</th><th>Trạng thái</th></tr></thead><tbody>
<c:forEach items="${dashboard.lowStockProducts}" var="item" varStatus="s"><tr><td>${s.count}</td><td>${item.code}</td><td>${item.name}</td><td>${item.categoryName}</td><td><strong>${item.qty}</strong></td><td><span class="label label-warning">Sắp hết hàng</span></td></tr></c:forEach>
<c:if test="${empty dashboard.lowStockProducts}"><tr><td colspan="6" class="text-center"><span class="label label-success">Kho đang ổn định</span></td></tr></c:if></tbody></table></div></div></div></div>
</div>
<script src="<c:url value='/resources/vendors/Chart.js/dist/Chart.min.js'/>"></script>
<script>
(function(){
var labels=[<c:forEach items="${dashboard.chartLabels}" var="v" varStatus="s">'${v}'<c:if test="${!s.last}">,</c:if></c:forEach>];
var receipts=[<c:forEach items="${dashboard.receiptData}" var="v" varStatus="s">${v}<c:if test="${!s.last}">,</c:if></c:forEach>];
var issues=[<c:forEach items="${dashboard.issueData}" var="v" varStatus="s">${v}<c:if test="${!s.last}">,</c:if></c:forEach>];
new Chart(document.getElementById('inventoryFlowChart').getContext('2d'),{type:'bar',data:{labels:labels,datasets:[{label:'Nhập kho',data:receipts,backgroundColor:'rgba(38,166,154,.75)'},{label:'Xuất kho',data:issues,backgroundColor:'rgba(239,83,80,.75)'}]},options:{responsive:true,scales:{yAxes:[{ticks:{beginAtZero:true}}]}}});
var categoryLabels=[<c:forEach items="${dashboard.categoryStocks}" var="v" varStatus="s">'${v.categoryName}'<c:if test="${!s.last}">,</c:if></c:forEach>];
var categoryData=[<c:forEach items="${dashboard.categoryStocks}" var="v" varStatus="s">${v.qty}<c:if test="${!s.last}">,</c:if></c:forEach>];
new Chart(document.getElementById('categoryStockChart').getContext('2d'),{type:'doughnut',data:{labels:categoryLabels,datasets:[{data:categoryData,backgroundColor:categoryLabels.map(function(_,i){return ['#26A69A','#EF5350','#42A5F5','#FFCA28','#AB47BC','#8D6E63','#66BB6A','#FF7043','#5C6BC0','#EC407A'][i%10];})}]},options:{responsive:true,legend:{position:'bottom'}}});
})();
</script>
