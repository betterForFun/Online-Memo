<nav class="navbar navbar-expand-md navbar-light bg-light mb-3 p-1">
    <a class="navbar-brand m-1" href="https://github.com/betterForFun">BetterForFun</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
            <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="/todos">Todos</a></li>
            <li class="nav-item">
                <button class="btn btn-primary" onclick="openTimezoneArea()">Timezone</button>
            </li>
        </ul>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Background Overlay -->
<div id="overlay" onclick="closeTimezoneArea()"></div>

<!-- Timezone Area -->
<div id="timezoneArea" class="hidden">
    <h3>Added Times</h3>
    <div id="timeList" class="time-list"></div>
    <div class="buttons-container">
        <button class="btn btn-success" onclick="showAddTimeForm()">Add Time</button>
        <button class="btn btn-secondary" onclick="closeTimezoneArea()">Cancel</button>
    </div>
</div>

<!-- Add Time Form -->
<div id="addTimeForm" class="hidden">
    <h3>Select Time & Time Zone</h3>
    <input type="time" id="timeInput" class="form-control">
    <select id="timezoneInput" class="form-control">
        <option value="UTC-5">EST (UTC-5)</option>
        <option value="UTC-6">CST (UTC-6)</option>
        <option value="UTC-7">MST (UTC-7)</option>
        <option value="UTC-8">PST (UTC-8)</option>
    </select>
    <div class="buttons-container">
        <button class="btn btn-primary" onclick="addTime()">Save</button>
        <button class="btn btn-secondary" onclick="closeAddTimeForm()">Cancel</button>
    </div>
</div>

<!-- CSS Styles -->
<style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        background-color: #f4f4f4;
    }
    .hidden {
        display: none;
    }
    #overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        z-index: 2;
    }
    #timezoneArea, #addTimeForm {
        display: none;
        background-color: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        width: 500px;
        margin: 40px auto;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 3;
    }
    .time-entry {
        background: #e9ecef; /* Light background */
        color: #333;  /* Dark text for readability */
        padding: 15px;
        margin-bottom: 12px;
        border-radius: 8px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
    }
    .buttons-container {
        display: flex;
        justify-content: space-between;
    }
    .time-list {
        margin-top: 20px;
        padding: 10px;
        background-color: #f8f9fa;  /* Light background for the list */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-height: 300px;
        overflow-y: auto;
    }
</style>

<!-- JavaScript -->
<script>
    function openTimezoneArea() {
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('timezoneArea').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }

    function closeTimezoneArea() {
        document.getElementById('overlay').style.display = 'none';
        document.getElementById('timezoneArea').style.display = 'none';
        document.body.style.overflow = '';
        closeAddTimeForm(); // Close form if open
    }

    function showAddTimeForm() {
        document.getElementById('addTimeForm').style.display = 'block';
    }

    function closeAddTimeForm() {
        document.getElementById('addTimeForm').style.display = 'none';
    }

    function addTime() {
        const time = document.getElementById('timeInput').value;
        const timezone = document.getElementById('timezoneInput').value;
        console.log('Time:', time);
        console.log('Timezone:', timezone);
        if (time) {
            const entry = document.createElement('div');
            entry.className = 'time-entry';
            entry.innerHTML = `
                            <span><strong>Time:` + time + `</strong><br> <strong>Time Zone:` + timezone + `</strong></span>
                            <button onclick='this.parentElement.remove()' class='btn btn-danger btn-sm'>Remove</button>
                        `;
            console.log(entry);
            document.getElementById('timeList').appendChild(entry);
            closeAddTimeForm();
        }
    }
</script>
