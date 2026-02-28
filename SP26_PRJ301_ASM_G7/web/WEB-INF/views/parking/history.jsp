<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch sử ra vào | Smart Parking</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    </head>
    <body class="bg-light">

        <jsp:include page="/WEB-INF/views/layout/staff-header.jsp" />

        <main class="container-fluid d-flex justify-content-center" style="max-width: 1400px; min-height: calc(100vh - 80px); padding: 6rem 15px 2rem 15px;">

            <div class="offcanvas offcanvas-start border-0 shadow" tabindex="-1" id="sidebarOffcanvas" style="width: 280px;">
                <div class="offcanvas-header border-bottom">
                    <h5 class="fw-bold mb-0 text-success"><i class="bi bi-p-square-fill me-2"></i>Smart Parking</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body d-flex flex-column p-3">
                    <jsp:include page="/WEB-INF/views/layout/sidebar.jsp">
                        <jsp:param name="activepage" value="parking/history" />
                    </jsp:include>
                </div>
            </div>

            <div class="w-100">
                <div class="d-flex justify-content-between align-items-end mb-4">
                    <div>
                        <h4 class="fw-bold text-dark mb-1">Lịch sử ra vào bãi</h4>
                    </div>

                    <button class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                        <i class="bi bi-download me-1"></i> Xuất Excel
                    </button>
                </div>

                <div class="card shadow-sm border-0" style="border-radius: 16px;">

                    <div class="card-header bg-white border-bottom py-3 px-4" style="border-top-left-radius: 16px; border-top-right-radius: 16px;">
                        <form action="${ctx}/parking/history" method="GET" class="row g-2 align-items-center">
                            <div class="col-md-4 col-sm-6 position-relative">
                                <i class="bi bi-search position-absolute top-50 start-0 translate-middle-y ms-3 text-muted"></i>
                                <input type="text" name="search" class="form-control form-control-sm ps-5 rounded-pill" placeholder="Tìm biển số xe hoặc mã thẻ..." value="${param.search}">
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <select name="state" class="form-select form-select-sm rounded-pill" onchange="this.form.submit()">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="parked" ${param.state == 'parked' ? 'selected' : ''}>Đang đỗ</option>
                                    <option value="completed" ${param.state == 'completed' ? 'selected' : ''}>Đã ra</option>
                                </select>
                            </div>
                        </form>
                    </div>

                    <div class="card-body p-0 table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light text-muted" style="font-size: 0.85rem;">
                                <tr>
                                    <th class="ps-4 py-3">Biển số xe</th>
                                    <th class="py-3">Hành động</th>
                                    <th class="py-3">Thời gian ghi nhận</th>
                                    <th class="py-3">Trạng thái</th>
                                    <th class="pe-4 py-3 text-end">Chi tiết</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="log" items="${recentLogs}">

                                    <%-- Logic set màu sắc và Icon (Giữ nguyên của bạn) --%>
                                    <c:choose>
                                        <c:when test="${log.sessionState == 'parked' || log.sessionState == 'PARKED' || log.sessionState == 'ACTIVE'}">
                                            <c:set var="actionName" value="Xe vào bãi" />
                                            <c:set var="badgeClass" value="bg-primary-subtle text-primary" />
                                            <c:set var="icon" value="bi-arrow-down-circle" />
                                            <c:set var="statusText" value="Đang đỗ" />
                                        </c:when>
                                        <c:when test="${log.sessionState == 'completed' || log.sessionState == 'COMPLETED'}">
                                            <c:set var="actionName" value="Xe ra bãi" />
                                            <c:set var="badgeClass" value="bg-success-subtle text-success" />
                                            <c:set var="icon" value="bi-arrow-up-circle" />
                                            <c:set var="statusText" value="Đã ra" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="actionName" value="Lỗi Dữ liệu" />
                                            <c:set var="badgeClass" value="bg-secondary-subtle text-secondary" />
                                            <c:set var="icon" value="bi-question-circle" />
                                            <c:set var="statusText" value="Lỗi" />
                                        </c:otherwise>
                                    </c:choose>

                                    <tr>
                                        <td class="ps-4">
                                            <span class="fw-bold text-dark fs-6">${log.licensePlate}</span>
                                        </td>
                                        <td>
                                            <span class="${badgeClass} fw-medium px-2 rounded" style="font-size: 0.8rem; padding-top: 4px; padding-bottom: 4px;">
                                                <i class="bi ${icon} me-1"></i> ${actionName}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-muted"><i class="bi bi-clock me-1"></i> ${log.formattedTime}</span>
                                        </td>
                                        <td>
                                            <span class="badge ${badgeClass}" style="font-size: 0.75rem;">${statusText}</span>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <button class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty recentLogs}">
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">
                                            <i class="bi bi-inbox fs-1 d-block mb-2 text-light"></i>
                                            <span>Không tìm thấy lịch sử ra vào nào.</span>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${not empty recentLogs}">
                        <div class="card-footer bg-white border-top py-3 d-flex justify-content-between align-items-center" style="border-bottom-left-radius: 16px; border-bottom-right-radius: 16px;">
                            <span class="text-muted" style="font-size: 0.85rem;">Hiển thị 20 kết quả mới nhất</span>
                            <ul class="pagination pagination-sm mb-0">
                                <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                            </ul>
                        </div>
                    </c:if>

                </div>
            </div>
        </main>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>                    
    </body>
</html>