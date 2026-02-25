<%@page import="model.ParkingSite"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Sơ đồ bãi xe - Overview</title>

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap-icons.css" rel="stylesheet">

        <style>
            /* --- ROOT & BASE CSS --- */
            :root {
                --bs-body-bg: #f3f4f6;
                --bs-primary: #1a56db;
                --bs-primary-rgb: 26, 86, 219;
                --bs-font-sans-serif: 'Inter', sans-serif;
                --text-main: #374151;
                --text-muted: #6b7280;
                --navbar-height: 70px;
            }
            body {
                font-family: var(--bs-font-sans-serif);
                color: var(--text-main);
                -webkit-font-smoothing: antialiased;
                background-color: var(--bs-body-bg);
                padding-top: var(--navbar-height);
                margin: 0;
            }

            /* --- CUSTOM COMPONENT CSS --- */
            .panel-container {
                max-width: 800px;
                margin: 0 auto;
            }

            .card-hero {
                border: none;
                border-radius: 20px;
                box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
                background: #fff;
                overflow: hidden;
            }

            .badge-custom {
                font-weight: 600;
                padding: 8px 16px;
                border-radius: 30px;
                letter-spacing: 0.5px;
            }

            .zone-card {
                background: #f8fafc;
                transition: all 0.2s ease-in-out;
            }
            .zone-card:hover {
                background: #ffffff;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                transform: translateY(-2px);
            }

            .giant-number {
                font-size: 5rem;
                letter-spacing: -2px;
            }
        </style>
    </head>
    <body>

        <main class="container-fluid py-4 py-lg-5 panel-container">
            <jsp:include page="/WEB-INF/views/layout/sidebar.jsp"/>
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb small">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/staff/dashboard" class="text-decoration-none text-muted">Bảng điều khiển</a></li>
                    <li class="breadcrumb-item active fw-medium text-primary" aria-current="page">Tổng quan bãi xe</li>
                </ol>
            </nav>

            <div class="card card-hero">

                <div class="card-header bg-white border-bottom-0 pt-4 pb-2 px-4 px-xl-5 d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-3">
                    <div>
                        <h1 class="fw-bold mb-1 text-dark fs-3">${not empty overview.siteName ? overview.siteName : 'Bãi Đỗ Xe'}</h1>
                        <p class="text-muted mb-0 d-flex align-items-center small">
                            <i class="bi bi-geo-alt-fill text-danger me-1"></i> 
                            ${not empty overview.address ? overview.address : 'Chưa cập nhật địa chỉ'}
                        </p>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${overview.operatingState.name() == 'ACTIVE'}">
                                <span class="badge bg-success badge-custom fs-6 shadow-sm">
                                    <i class="bi bi-door-open-fill me-1"></i> ${overview.operatingState.label}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger badge-custom fs-6 shadow-sm">
                                    <i class="bi bi-door-closed-fill me-1"></i> ${overview.operatingState.label}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="card-body px-4 px-xl-5 py-4">

                    <div class="d-flex justify-content-between align-items-end mb-3">
                        <div>
                            <div class="text-muted fw-bold mb-1" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">Chỗ còn trống</div>
                            <div class="fw-bold text-primary giant-number" style="line-height: 1;">${overview.totalAvailable}</div>
                        </div>
                        <div class="text-end">
                            <div class="text-muted fw-bold mb-1" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">Đã đỗ / Tổng</div>
                            <div class="fw-bold text-dark fs-2" style="line-height: 1;">
                                ${overview.totalOccupied} 
                                <span class="text-muted fw-normal fs-5">/ ${overview.totalCapacity}</span>
                            </div>
                        </div>
                    </div>

                    <hr class="text-muted opacity-25 my-4">

                    <div class="row g-3 mb-2">

                        <c:if test="${empty overview.areas}">
                            <div class="col-12 text-center text-muted py-4">
                                <i>Chưa có dữ liệu phân khu cho bãi xe này.</i>
                            </div>
                        </c:if>

                        <c:forEach items="${overview.areas}" var="area">

                            <c:choose>
                                <c:when test="${area.vehicleTypeName.toLowerCase().contains('car')}">
                                    <c:set var="borderColor" value="#3b82f6" />
                                    <c:set var="iconClass" value="bi-car-front-fill" />
                                    <c:set var="textColor" value="text-primary" />
                                </c:when>
                                <c:when test="${area.vehicleTypeName.toLowerCase().contains('motorbike')}">
                                    <c:set var="borderColor" value="#eab308" />
                                    <c:set var="iconClass" value="bi-bicycle" />
                                    <c:set var="textColor" value="text-warning" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="borderColor" value="#94a3b8" />
                                    <c:set var="iconClass" value="bi-p-circle-fill" />
                                    <c:set var="textColor" value="text-secondary" />
                                </c:otherwise>
                            </c:choose>

                            <div class="col-6">
                                <div class="border rounded p-3 h-100 zone-card" style="border-left: 4px solid ${borderColor} !important;">
                                    <div class="text-muted fw-bold mb-2 text-uppercase" style="font-size: 0.8rem;">
                                        <i class="bi ${iconClass} me-2 ${textColor}"></i>${area.areaName}
                                    </div>
                                    <div class="d-flex justify-content-between align-items-baseline">

                                        <c:choose>
                                            <c:when test="${area.availableSlots <= 0}">
                                                <div class="fw-bold text-danger fs-5" style="line-height: 1;">Hết chỗ</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="fw-bold ${textColor} fs-3" style="line-height: 1;">${area.availableSlots}</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="text-muted fw-medium" style="font-size: 0.8rem;">${area.occupiedSlots}/${area.totalSlots}</div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>

                    </div> </div>
            </div>
                            
                            
        </main>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>