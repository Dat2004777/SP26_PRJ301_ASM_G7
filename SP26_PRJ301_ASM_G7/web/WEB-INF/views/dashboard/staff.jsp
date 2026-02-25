<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Cổng Nhân Viên - Kiểm Soát Xe</title>

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>

        <style>
            :root {
                --bs-primary: #2563eb; /* Màu xanh hiện đại giống mockup */
                --bs-body-bg: #f3f4f6;
                --navbar-height: 70px;
            }
            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bs-body-bg);
                padding-top: var(--navbar-height);
            }

            /* NAVBAR HEADER */
            .navbar-custom {
                height: var(--navbar-height);
                box-shadow: 0 1px 2px rgba(0,0,0,0.05);
                background-color: #fff;
            }
            .header-clock {
                font-weight: 600;
                color: #475569;
                background: #f1f5f9;
                padding: 8px 16px;
                border-radius: 8px;
                font-variant-numeric: tabular-nums;
            }

            /* THỐNG KÊ (STATS CARDS) */
            .stat-card {
                border: none;
                border-radius: 16px;
                background: #fff;
                box-shadow: 0 4px 6px -1px rgba(0,0,0,0.02);
                padding: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            /* MAIN FORM CARD */
            .form-card {
                border: none;
                border-radius: 20px;
                background: #fff;
                box-shadow: 0 10px 15px -3px rgba(0,0,0,0.05);
                padding: 2.5rem;
            }

            /* TAB SWITCH (Vào bãi / Ra bãi) */
            .tab-switch {
                display: flex;
                background: #f8fafc;
                border-radius: 12px;
                padding: 6px;
                margin-bottom: 2rem;
            }
            .tab-switch button {
                flex: 1;
                border: none;
                background: transparent;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                color: #64748b;
                transition: all 0.2s;
            }
            /* TAB SWITCH (Vào bãi / Ra bãi) */
            .tab-switch {
                display: flex;
                background: #f8fafc;
                border-radius: 12px;
                padding: 6px;
                margin-bottom: 2rem;
            }
            .tab-switch button {
                flex: 1;
                border: none;
                background: transparent;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                color: #64748b;
                transition: all 0.2s;
            }

            /* Màu nền xanh dương, chữ trắng cho toàn bộ Tab VÀO BÃI */
            .tab-switch button#tabIn.active {
                background: var(--bs-primary);
                color: #fff;
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
            }

            /* Màu nền xanh lá, chữ trắng cho toàn bộ Tab RA BÃI */
            .tab-switch button#tabOut.active {
                background: #10b981;
                color: #fff;
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            }

            /* INPUT FIELDS */
            .input-group-custom {
                position: relative;
                margin-bottom: 1.5rem;
            }
            .input-group-custom .form-label {
                font-size: 0.85rem;
                font-weight: 600;
                color: #475569;
                margin-bottom: 0.5rem;
            }
            .input-group-custom input {
                background: #f8fafc;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                padding: 16px 16px 16px 48px;
                font-size: 1.1rem;
                font-weight: 500;
                width: 100%;
                transition: all 0.2s;
            }
            .input-group-custom input:focus {
                outline: none;
                border-color: var(--bs-primary);
                background: #fff;
                box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            }
            .input-group-custom .icon-left {
                position: absolute;
                bottom: 18px;
                left: 16px;
                color: #94a3b8;
                font-size: 1.2rem;
            }

            /* NÚT XÁC NHẬN */
            .btn-submit {
                background: var(--bs-primary);
                color: #fff;
                border: none;
                border-radius: 12px;
                padding: 16px;
                font-size: 1.1rem;
                font-weight: 600;
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                transition: all 0.2s;
            }
            .btn-submit:hover {
                background: #1d4ed8;
                transform: translateY(-2px);
            }
            .btn-submit.btn-checkout {
                background: #10b981; /* Màu xanh lá cho nút ra bãi */
            }
            .btn-submit.btn-checkout:hover {
                background: #059669;
            }

            /* OFF CANVAS SIDEBAR (Nav) */
            .sidebar-nav .nav-link {
                color: #475569;
                font-weight: 500;
                padding: 12px 20px;
                border-radius: 8px;
                margin-bottom: 4px;
            }
            .sidebar-nav .nav-link:hover, .sidebar-nav .nav-link.active {
                background: #eff6ff;
                color: var(--bs-primary);
            }
        </style>
    </head>
    <body>

        <!--        header-->
        <nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3 px-md-4">
            <div class="container-fluid p-0 d-flex justify-content-between align-items-center">

                <div class="d-flex align-items-center gap-3">
                    <button class="btn btn-light border-0 bg-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas">
                        <i class="bi bi-list fs-4"></i>
                    </button>
                    <div class="d-none d-sm-block">
                        <div class="fw-bold fs-5" style="line-height: 1.2; color: #1e293b;">${stats.siteName}</div>
                    </div>
                </div>

                <div class="header-clock d-none d-md-flex align-items-center gap-2">
                    <i class="bi bi-clock"></i>
                    <span id="realtimeClock">00:00:00</span> - <span id="realtimeDate">--/--/----</span>
                </div>

                <div class="d-flex align-items-center gap-4">
                    <button class="btn btn-light rounded-circle position-relative" type="button" data-bs-toggle="offcanvas" data-bs-target="#historyOffcanvas" title="Nhật ký hoạt động">
                        <i class="bi bi-bell fs-5"></i>
                        <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                    </button>

                    <div class="d-flex align-items-center gap-3 border-start ps-4">
                        <div class="text-end d-none d-lg-block">
                            <div class="fw-bold text-dark" style="font-size: 0.95rem;">${stats.empName}</div>
                        </div>
                        <img src="https://ui-avatars.com/api/?name=SP&background=eff6ff&color=2563eb" alt="Avatar" class="rounded-circle" width="42" height="42">
                    </div>
                </div>
            </div>
        </nav>


        <main class="container-fluid" style="max-width: 1200px; padding-top: 2rem;">

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card">
                        <div>
                            <p class="text-muted fw-medium mb-1">Chỗ còn trống</p>
                            <h2 class="fw-bold mb-0 text-primary">${stats.availableSpaces}</h2>
                        </div>
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary"><i class="bi bi-p-square-fill"></i></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div>
                            <p class="text-muted fw-medium mb-1">Chỗ đã đỗ</p>
                            <h2 class="fw-bold mb-0" style="color: #475569;">${stats.occupiedSpaces}</h2>
                        </div>
                        <div class="stat-icon bg-secondary bg-opacity-10 text-secondary"><i class="bi bi-car-front-fill"></i></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card">
                        <div>
                            <p class="text-muted fw-medium mb-1">Tổng sức chứa</p>
                            <h2 class="fw-bold mb-0 text-dark">${stats.totalCapacity}</h2>
                        </div>
                        <div class="stat-icon bg-light text-dark border"><i class="bi bi-buildings-fill"></i></div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6">
                    <div class="form-card">

                        <div class="tab-switch" id="formTabs">
                            <button type="button" class="active" id="tabIn" onclick="switchMode('in')">
                                VÀO BÃI <span class="fw-bold opacity-75 ms-1">[F1]</span>
                            </button>
                            <button type="button" id="tabOut" onclick="switchMode('out')">
                                RA BÃI <span class="fw-bold opacity-75 ms-1">[F2]</span>
                            </button>
                        </div>

                        <form action="${ctx}/parking/checkin" method="POST" id="mainGateForm">
                            <input type="hidden" name="actionType" id="actionType" value="checkin">

                            <div class="input-group-custom">
                                <label class="form-label">MÃ SỐ THẺ</label>
                                <i class="bi bi-credit-card-2-front icon-left"></i>
                                <input type="text" id="cardId" name="cardId" placeholder="Quét thẻ hoặc nhập mã số..." required autofocus autocomplete="off">
                            </div>

                            <div class="input-group-custom">
                                <label class="form-label">BIỂN SỐ XE</label>
                                <i class="bi bi-123 icon-left"></i>
                                <input type="text" id="licensePlate" name="licensePlate" placeholder="NHẬP BIỂN SỐ (VD: 30A-123.45)" required autocomplete="off" style="text-transform: uppercase;">
                            </div>

                            <div class="d-flex align-items-center gap-2 mb-4 mt-2">
                                <i class="bi bi-info-circle text-muted"></i>
                                <small class="text-muted">Nhấn phím <b>Enter</b> để xác nhận và gửi thông tin.</small>
                            </div>

                            <button type="button" id="btnSubmitForm" class="btn-submit" onclick="submitForm()">
                                <span>XÁC NHẬN VÀO</span> <i class="bi bi-box-arrow-in-right"></i>
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </main>

        <div class="offcanvas offcanvas-start border-0 shadow" tabindex="-1" id="sidebarOffcanvas" style="width: 280px;">
            <div class="offcanvas-header border-bottom">
                <h5 class="fw-bold mb-0 text-primary"><i class="bi bi-p-square-fill me-2"></i>Smart Parking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body d-flex flex-column p-3">
                <nav class="nav flex-column sidebar-nav flex-grow-1">
                    <a href="#" class="nav-link active"><i class="bi bi-arrow-left-right me-2"></i> Xử lý Vào/Ra</a>
                    <a href="#" class="nav-link"><i class="bi bi-grid-1x2 me-2"></i> Sơ đồ bãi xe</a>
                    <a href="#" class="nav-link"><i class="bi bi-search me-2"></i> Tra cứu thẻ/xe</a>
                    <a href="#" class="nav-link"><i class="bi bi-exclamation-triangle me-2"></i> Sự cố & Cảnh báo</a>
                </nav>
                <div class="mt-auto">
                    <a href="#" class="nav-link text-danger fw-bold"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
                </div>
            </div>
        </div>

        <div class="offcanvas offcanvas-end border-0 shadow" tabindex="-1" id="historyOffcanvas" style="width: 380px;">
            <div class="offcanvas-header border-bottom bg-light">
                <h6 class="fw-bold mb-0"><i class="bi bi-clock-history me-2"></i>Hoạt động gần đây</h6>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body p-0">
                <div class="list-group list-group-flush">

                    <c:forEach var="log" items="${recentLogs}" varStatus="loop">

                        <div class="list-group-item p-3 ${loop.index % 2 == 1 ? 'bg-light' : ''}">

                            <div class="d-flex justify-content-between mb-1">
                                <span class="fw-bold ${log.licensePlate == 'ERR-404' ? 'text-danger' : ''}">${log.licensePlate}</span>
                                <span class="badge badge-status ${log.badgeClass}">${log.badgeText}</span>
                            </div>

                            <div class="d-flex align-items-center justify-content-between mt-2">
                                <span class="${log.textClass} small fw-medium">
                                    <i class="bi ${log.iconClass} me-1"></i> ${log.actionName}
                                </span>
                                <small class="text-muted"><i class="bi bi-clock"></i> ${log.formattedTime} • ${log.dateLabel}</small>
                            </div>

                        </div>

                    </c:forEach>

                    <c:if test="${empty recentLogs}">
                        <div class="p-4 text-center text-muted">
                            <small>Chưa có hoạt động nào được ghi nhận.</small>
                        </div>
                    </c:if>

                </div>
                <div class="p-3 text-center border-top">
                    <a href="#" class="text-decoration-none text-primary small fw-semibold">Xem tất cả lịch sử</a>
                </div>
            </div>
        </div>


        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script>
                                // Các elements
                                const form = document.getElementById('mainGateForm');
                                const actionType = document.getElementById('actionType');
                                const tabIn = document.getElementById('tabIn');
                                const tabOut = document.getElementById('tabOut');
                                const cardIdInput = document.getElementById('cardId');
                                const plateInput = document.getElementById('licensePlate');
                                const btnSubmit = document.getElementById('btnSubmitForm');
                                const ctx = "${ctx}";

                                // 1. Logic Đổi Tab (Vào/Ra)
                                function switchMode(mode) {
                                    if (mode === 'in') {
                                        tabIn.classList.add('active');
                                        tabOut.classList.remove('active');
                                        actionType.value = 'checkin';
                                        form.action = ctx + '/parking/checkin';

                                        // Đổi UI Nút
                                        btnSubmit.classList.remove('btn-checkout');
                                        btnSubmit.innerHTML = '<span>XÁC NHẬN VÀO</span> <i class="bi bi-box-arrow-in-right"></i>';
                                    } else {
                                        tabOut.classList.add('active');
                                        tabIn.classList.remove('active');
                                        actionType.value = 'checkout';
                                        form.action = ctx + '/parking/checkout';

                                        // Đổi UI Nút
                                        btnSubmit.classList.add('btn-checkout');
                                        btnSubmit.innerHTML = '<span>XÁC NHẬN RA</span> <i class="bi bi-box-arrow-right"></i>';
                                    }
                                    // Xóa trắng & Focus lại
                                    cardIdInput.value = '';
                                    plateInput.value = '';
                                    cardIdInput.focus();
                                }

                                // 2. Logic Smart Focus & Submit bằng Enter
                                // Chặn phím Enter ở ô Mã thẻ, bắt nhảy xuống ô Biển số
                                cardIdInput.addEventListener('keydown', function (e) {
                                    if (e.key === 'Enter') {
                                        e.preventDefault();
                                        if (this.value.trim() !== '')
                                            plateInput.focus();
                                    }
                                });

                                // Phím Enter ở ô Biển số sẽ tự động gọi hàm submit
                                plateInput.addEventListener('keydown', function (e) {
                                    if (e.key === 'Enter') {
                                        e.preventDefault();
                                        submitForm();
                                    }
                                });

                                function submitForm() {
                                    if (cardIdInput.value.trim() === '' && plateInput.value.trim() === '') {
                                        // Tùy chọn: Dùng Toast của Bootstrap thay cho alert nếu muốn đẹp hơn
                                        alert('Vui lòng quét thẻ hoặc nhập biển số!');
                                        cardIdInput.focus();
                                        return;
                                    }
                                    form.submit();
                                }

                                // 3. Phím tắt F1 / F2 toàn cục
                                document.addEventListener('keydown', function (e) {
                                    if (e.key === 'F1') {
                                        e.preventDefault();
                                        switchMode('in');
                                    } else if (e.key === 'F2') {
                                        e.preventDefault();
                                        switchMode('out');
                                    }
                                });

                                // Tự động focus lại form nếu bấm ra ngoài màn hình
                                document.addEventListener('click', function (e) {
                                    const isClickInsideMenuOrNav = e.target.closest('.offcanvas') || e.target.closest('[data-bs-toggle]');
                                    const isClickInsideInput = e.target.id === 'cardId' || e.target.id === 'licensePlate';
                                    if (!isClickInsideMenuOrNav && !isClickInsideInput) {
                                        cardIdInput.value === '' ? cardIdInput.focus() : plateInput.focus();
                                    }
                                });

                                // 4. Đồng hồ Realtime
                                function updateClock() {
                                    const now = new Date();
                                    const timeString = now.toLocaleTimeString('vi-VN', {hour12: false});
                                    const dateString = now.toLocaleDateString('vi-VN', {day: '2-digit', month: '2-digit', year: 'numeric'});

                                    document.getElementById('realtimeClock').innerText = timeString;
                                    document.getElementById('realtimeDate').innerText = dateString;
                                }
                                setInterval(updateClock, 1000);
                                updateClock(); // Chạy ngay lập tức khi load trang
        </script>
    </body>
</html>