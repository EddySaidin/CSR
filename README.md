# MyProcse Starter Template

A minimal, production-ready Classic ASP web application template for IIS.

## 🚀 Features

- **Authentication System** - User login/logout with session management
- **Database Layer** - ADO database helpers and utilities
- **Security Features** - CSRF protection, input sanitization, SQL injection prevention
- **Responsive UI** - Bootstrap 5 + Font Awesome for modern interface
- **Modular Structure** - Organized includes for easy maintenance
- **Error Handling** - Centralized error management and logging

## 📁 Project Structure

```
template/
├── config/              # Configuration files
│   └── database.asp     # Database connections
├── includes/            # Reusable libraries
│   ├── functions.asp    # Core utilities
│   ├── auth.asp         # Authentication
│   ├── database.asp     # Database helpers
│   ├── security.asp     # Security utilities
│   ├── header.asp       # Common header
│   └── footer.asp       # Common footer
├── pages/               # Application pages
│   ├── login.asp        # Login page
│   ├── dashboard.asp    # Main dashboard
│   └── error.asp        # Error handling
├── assets/              # Static resources
│   ├── css/             # Stylesheets
│   ├── js/              # JavaScript
│   └── images/          # Images
├── web.config           # IIS configuration
├── default.asp          # Entry point
└── README.md            # This file
```

## 🛠️ Setup Instructions

### 1. IIS Configuration
- Enable Classic ASP in IIS Manager
- Create new application pool (Classic .NET AppPool)
- Set up virtual directory pointing to template folder

### 2. Database Setup
- Update connection strings in `config/database.asp`
- Create required database tables (see Database Schema below)
- Ensure SQL Server access permissions

### 3. File Permissions
- Grant IIS_IUSRS read/write access to upload folders
- Set proper permissions for session state directory

### 4. Security Configuration
- Update CSRF token generation if needed
- Configure HTTPS redirects in web.config
- Set up proper authentication method

## 🗄️ Database Schema

### Required Tables

#### `staff` Table
```sql
CREATE TABLE staff (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    LoginID VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Status_Active BIT DEFAULT 1,
    trx_profile INT
);
```

#### `profileAccess` Table
```sql
CREATE TABLE profileAccess (
    ID INT PRIMARY KEY IDENTITY(1,1),
    trx_profile INT NOT NULL,
    trx_apps INT NOT NULL,
    trx_group VARCHAR(50),
    isActive BIT DEFAULT 1
);
```

#### `Apps` Table
```sql
CREATE TABLE Apps (
    appsID INT PRIMARY KEY IDENTITY(1,1),
    apps_name VARCHAR(100) NOT NULL,
    apps_description TEXT,
    apps_folderName VARCHAR(100),
    apps_order INT DEFAULT 0,
    isHidden BIT DEFAULT 0
);
```

## 🎨 Customization

### Adding New Pages
1. Create new ASP file in `pages/` folder
2. Include necessary libraries: `<!--#include file="../includes/functions.asp"-->`
3. Use header/footer includes for consistent layout
4. Implement proper authentication checks

### Adding New Functions
1. Create new include file in `includes/` folder
2. Include it in pages that need the functionality
3. Follow naming conventions and error handling patterns

### Styling
- Modify `assets/css/main.css` for custom styles
- Use Bootstrap classes for responsive design
- Add custom CSS classes as needed

## 🔒 Security Best Practices

- **Input Validation**: Always validate and sanitize user input
- **SQL Injection**: Use parameterized queries with `ParaRs()` function
- **XSS Prevention**: Use `sanitizeInput()` function for output
- **CSRF Protection**: Include CSRF tokens in forms
- **Session Management**: Proper session timeout and cleanup
- **HTTPS**: Enforce HTTPS in production

## 📱 Responsive Design

The template includes:
- Bootstrap 5 for responsive grid system
- Mobile-first CSS approach
- Touch-friendly navigation
- Responsive tables and forms

## ⚡ Performance Tips

- Use `setRs()` for read-only operations
- Implement proper database indexing
- Cache frequently accessed data in session
- Minimize database connections
- Use stored procedures for complex operations

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Errors**
   - Check connection strings in `config/database.asp`
   - Verify SQL Server is running and accessible
   - Check firewall and network settings

2. **Permission Errors**
   - Ensure IIS_IUSRS has proper access
   - Check file and folder permissions
   - Verify application pool identity

3. **Session Issues**
   - Check session state configuration in web.config
   - Verify session timeout settings
   - Check for session conflicts

## 📞 Support

For issues and questions:
1. Check IIS logs in `%SystemDrive%\inetpub\logs\LogFiles`
2. Enable detailed error messages in web.config
3. Check Windows Event Viewer for system errors

## 📄 License

This template is provided as-is for educational and development purposes.

---

**Happy Coding! 🎉** 