<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Google Fonts: Inter -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3 px-md-4">
    <div class="container-fluid p-0 d-flex justify-content-between align-items-center">

        <div class="d-flex align-items-center gap-3">
            <button class="btn btn-light border-0 bg-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas">
                <i class="bi bi-list fs-4"></i>
            </button>
            <div class="d-sm-block">
                <div class="fw-bold fs-5" style="line-height: 1.2; color: #1e293b;">${overview.siteName}</div>
            </div>
        </div>

        <div class="header-clock d-md-flex align-items-center gap-2">
            <i class="bi bi-clock"></i>
            <span id="realtimeClock">00:00:00</span> - <span id="realtimeDate">--/--/----</span>
        </div>

        <div class="d-flex align-items-center gap-4">

        </div>
    </div>
</nav>

<style>
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

    .badge-soft-success {
        background-color: #dcfce7 !important;
        color: #15803d !important; /* Đậm màu chữ thêm một chút */
        border: 1px solid #bbf7d0 !important; /* Viền mỏng giúp Badge không bị chìm */
        font-weight: 600 !important;
        padding: 6px 12px !important;
        border-radius: 20px !important;
    }

    .badge-soft-warning {
        background-color: #fff7ed !important;
        color: #c2410c !important;
        border: 1px solid #fed7aa !important;
        font-weight: 600 !important;
        padding: 6px 12px !important;
        border-radius: 20px !important;
    }

    .badge-soft-danger {
        background-color: #fef2f2 !important;
        color: #b91c1c !important;
        border: 1px solid #fecaca !important;
        font-weight: 600 !important;
        padding: 6px 12px !important;
        border-radius: 20px !important;
    }

    .badge-outline {
        background-color: #f8fafc !important;
        color: var(--text-main) !important;
        border: 1px solid #cbd5e1 !important;
        font-weight: 600 !important;
        padding: 6px 12px !important;
        border-radius: 20px !important;
    }

</style>            
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {

        // 1. Khai báo lấy phần tử HTML
        const clockTimeEl = document.getElementById('realtimeClock');
        const clockDateEl = document.getElementById('realtimeDate');

        // 2. Hàm cập nhật thời gian
        function updateClock() {
            if (clockTimeEl && clockDateEl) {
                const now = new Date();
                clockTimeEl.innerText = now.toLocaleTimeString('vi-VN', {hour12: false});
                clockDateEl.innerText = now.toLocaleDateString('vi-VN', {day: '2-digit', month: '2-digit', year: 'numeric'});
            }
        }

        // 3. Chạy đồng hồ
        setInterval(updateClock, 1000);
        updateClock(); // Gọi ngay 1 lần để không bị chờ 1 giây đầu
    });
</script>
