# Brute Force / Password Spraying Emulation Script
1..10 | ForEach-Object {
     = net use \\127.0.0.1\c$ "WrongPassword" /user:FakeUser 2>&1
}
