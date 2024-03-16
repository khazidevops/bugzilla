docker-compose up -d --build   

docker-compose down      



git cmd

PS D:\repo\Bugzilla> git add .
PS D:\repo\Bugzilla> git commit -m "edit db user bugs"    
[main 3287552] edit db user bugs
 1 file changed, 1 insertion(+), 1 deletion(-)
PS D:\repo\Bugzilla> git push -u origin main
fatal: credential-cache unavailable; no unix socket support
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 12 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 294 bytes | 294.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/khazidevops/bugzilla.git
   b31ab07..3287552  main -> main
branch 'main' set up to track 'origin/main'.
PS D:\repo\Bugzilla>