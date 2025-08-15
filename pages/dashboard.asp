<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/functions.asp"-->
<!--#include file="../includes/auth.asp"-->
<%
pageTitle = "Dashboard - My Application"

' Require authentication
Call requireAuth()

' Get user statistics
Dim userCount, activeUsers
userCount = getSingleValue("SELECT COUNT(*) FROM staff", con_profile)
activeUsers = getSingleValue("SELECT COUNT(*) FROM staff WHERE Status_Active = 1", con_profile)
%>
<!--#include file="../includes/header.asp"-->

<div class="row">
    <div class="col-12">
        <h1 class="mb-4"><i class="fas fa-tachometer-alt"></i> Dashboard</h1>
    </div>
</div>

<div class="row">
    <div class="col-md-4 mb-4">
        <div class="card bg-primary text-white">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">Total Users</h4>
                        <h2 class="mb-0"><%=userCount%></h2>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-users fa-3x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 mb-4">
        <div class="card bg-success text-white">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">Active Users</h4>
                        <h2 class="mb-0"><%=activeUsers%></h2>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-user-check fa-3x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4 mb-4">
        <div class="card bg-info text-white">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">Welcome</h4>
                        <h5 class="mb-0"><%=Session("name")%></h5>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-hand-wave fa-3x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-clock"></i> Recent Activity</h5>
            </div>
            <div class="card-body">
                <p class="text-muted">No recent activity to display.</p>
            </div>
        </div>
    </div>
</div>

<!--#include file="../includes/footer.asp"--> 