<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />
<c:set var="role" value="${sessionScope.userRole != null ? sessionScope.userRole : 'STAFF'}" />

<style>
    /* CSS giữ nguyên - Tối giản cho Component */
    .sidebar-nav-link {
        display: flex;
        align-items: center;
        padding: 0.6rem 1rem;
        margin-bottom: 2px;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        color: #374151;
        transition: all 0.2s ease;
    }
    .sidebar-nav-link:hover:not(.active) {
        background-color: #f1f5f9;
        transform: translateX(4px);
        color: #0f172a;
    }

    /* Active States */
    .sidebar-nav-link.active {
        pointer-events: none;
    }
    .link-admin.active {
        background-color: #eff6ff;
        color: #1a56db !important;
        font-weight: 700;
    }
    .link-staff.active {
        background-color: #f0fdf4;
        color: #15803d !important;
        font-weight: 700;
    }

</style>

<nav class="nav flex-column flex-grow-1 gap-1 w-100">
    <c:choose>
        <%-- ================= MENU ADMIN ================= --%>
        <c:when test="${role == 'ADMIN'}">
            <a href="${ctx}/dashboard" class="sidebar-nav-link link-admin ${uri.endsWith('/dashboard') ? 'active' : ''}">
                <i class="bi bi-grid-1x2 me-2"></i> Bảng điều khiển
            </a>

            <div class="nav-section-title">Quản lý tổng</div>
            <a href="${ctx}/sites" class="sidebar-nav-link link-admin ${uri.contains('/sites') ? 'active' : ''}">
                <i class="bi bi-car-front me-2"></i> Quản lý bãi xe
            </a>
            <a href="${ctx}/employees" class="sidebar-nav-link link-admin ${uri.contains('/employees') ? 'active' : ''}">
                <i class="bi bi-people me-2"></i> Nhân viên
            </a>
            <a href="${ctx}/cards" class="sidebar-nav-link link-admin ${uri.contains('/cards') ? 'active' : ''}">
                <i class="bi bi-card-heading me-2"></i> Vé tháng
            </a>

            <div class="nav-section-title text-primary"><i class="bi bi-person-badge me-1"></i> Giao diện Staff</div>
            <a href="${ctx}/parking-monitor" class="sidebar-nav-link link-admin ${uri.endsWith('/parking-monitor') ? 'active' : ''}">
                <i class="bi bi-p-square me-2"></i> Sơ đồ bãi xe
            </a>
            <a href="${ctx}/lookup-registry" class="sidebar-nav-link link-admin ${uri.endsWith('/lookup-registry') ? 'active' : ''}">
                <i class="bi bi-search me-2"></i> Tra cứu thẻ/xe
            </a>
        </c:when>

        <%-- ================= MENU STAFF ================= --%>
        <c:otherwise>
            <div class="nav-section-title mb-2 text-uppercase fw-bold text-primary" style="letter-spacing: 0.5px; font-size: 0.75rem;">
                Nghiệp vụ trực ca
            </div>

            <a href="${ctx}/dashboard" class="sidebar-nav-link link-staff py-2 ${uri.endsWith('/dashboard') ? 'active' : ''}" 
               >
                <i class="bi bi-door-open-fill me-2"></i> Xử lý Vào/Ra
            </a>
            <a href="${ctx}/parking/history" class="sidebar-nav-link link-staff py-2 mb-3 ${uri.endsWith('/parking/history') ? 'active' : ''}">
                <i class="bi bi-clock-history me-2"></i> Nhật ký lượt xe
            </a>

            <div class="nav-section-title mb-2 text-uppercase fw-bold text-primary" style="letter-spacing: 0.5px; font-size: 0.75rem;">
                Công cụ điều hành
            </div>

            <div class="nav-group d-flex flex-column gap-1">
                <a href="${ctx}/search" class="sidebar-nav-link link-staff py-2 ${uri.endsWith('/search') ? 'active' : ''}">
                    <i class="bi bi-search-heart me-2"></i> Truy vấn phương tiện
                </a>

                <a href="${ctx}/subscription" class="sidebar-nav-link link-staff py-2 ${uri.endsWith('/subscription') ? 'active' : ''}">
                    <i class="bi bi-card-heading me-2"></i> Quản lý vé tháng
                </a>

            </div>
        </c:otherwise>
    </c:choose>
</nav>

<div class="mt-auto border-top pt-3 w-100">
    <div class="d-flex align-items-center mb-3 px-2">
        <c:choose>
            <c:when test="${role == 'ADMIN'}">
                <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px; font-weight: bold;">AD</div>
                <div class="overflow-hidden">
                    <div class="fw-bold text-dark text-truncate" style="font-size: 0.85rem;">Quản trị viên</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="rounded-circle bg-success text-white d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px; font-weight: bold;">NV</div>
                <div class="overflow-hidden">
                    <div class="fw-bold text-dark text-truncate" style="font-size: 0.85rem;">Nhân viên trực</div>
                    <div class="text-success" style="font-size: 0.75rem;"><i class="bi bi-circle-fill me-1" style="font-size: 0.4rem;"></i>Đang trong ca</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <a href="${pageContext.request.contextPath}/logout" class="sidebar-nav-link text-danger fw-bold hover-bg-light">
        <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
    </a>
</div>