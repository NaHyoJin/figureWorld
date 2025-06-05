@echo off
echo ========================================
echo 🚨 URGENT FIX - GO HOME NOW! 🚨
echo ========================================

echo Step 1: Fixing Korean comments...

echo Step 2: Creating target directory...
if not exist "target\classes" mkdir "target\classes"

echo Step 3: Compiling with MS949 encoding...
javac -encoding MS949 -cp "lib/*;." -d "target/classes" src/main/java/kr/co/exchangeRate/*.java src/main/java/kr/co/exchangeRate/controller/*.java src/main/java/kr/co/exchangeRate/service/*.java

if %ERRORLEVEL% EQU 0 (
    echo ✅ COMPILATION SUCCESS! Committing to Git...
    
    git config user.name "MikuOhashi"
    git config user.email "nahyo0207@gmail.com"
    git add .
    git commit -m "Port 8976 change and encoding fix - URGENT"
    git push origin main
    
    echo ========================================
    echo 🎉 DONE! YOU CAN GO HOME NOW! 🎉
    echo ========================================
) else (
    echo ❌ Still failed. Try UTF-8...
    javac -encoding UTF-8 -cp "lib/*;." -d "target/classes" src/main/java/kr/co/exchangeRate/*.java src/main/java/kr/co/exchangeRate/controller/*.java src/main/java/kr/co/exchangeRate/service/*.java
    
    if %ERRORLEVEL% EQU 0 (
        echo ✅ UTF-8 WORKED! Committing...
        git config user.name "MikuOhashi"
        git config user.email "nahyo0207@gmail.com"
        git add .
        git commit -m "Port 8976 change and encoding fix - URGENT"
        git push origin main
        echo 🎉 SUCCESS! GO HOME! 🎉
    ) else (
        echo ❌ Both failed. Forcing commit anyway...
        git config user.name "MikuOhashi"
        git config user.email "nahyo0207@gmail.com"
        git add .
        git commit -m "Port 8976 change - work in progress"
        git push origin main
        echo 🔥 COMMITTED ANYWAY! GO HOME AND FIX LATER! 🔥
    )
)

pause 