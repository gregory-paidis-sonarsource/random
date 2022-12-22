import os

PROJECTS = [
( "https://github.com/akkadotnet/akka.net.git", "a920b0723625e918e0b3e93e4b7f4a33e5533f5b"),
( "https://github.com/beyourmarket/beyourmarket.git", "v.1.3.0-beta"),
( "https://github.com/CodeHubApp/CodeHub.git", "0f3cb72c9d2faf8f0fb83cadde595142e661725f"),
( "https://github.com/fluentassertions/fluentassertions.git", "371ab153276c19fd04c94333b3d32adb5a13b203"),
( "https://github.com/tmenier/Flurl.git", "0affa6e"),
( "https://github.com/Fody/Fody.git", "3f766f8f6b9ffccc616a35a77e472d44f65d5394"),
( "https://github.com/JabbR/JabbR.git", "eb5b4e2f1e5bdbb1ea91230f1884716170a6976d"),
( "https://github.com/MassTransit/MassTransit.git", "23ec7556eb4f7466f173c1af91bc41f6be9e70f9"),
# net5 solution, steal it from ITs
# net6 solution, steal it from ITs
( "https://github.com/nhibernate/nhibernate-core", "14c5cdb3fe71a649f2deb1e23d0e9088ebdf3738"),
( "https://github.com/nodatime/nodatime.git", "871ba40d487d4d4dfe0b2434aa6f1eac05cddc98"),
( "https://github.com/bitsadmin/nopowershell.git", "136dcdfca04f3304d14a9b479407b84e0128aba0"),
( "https://github.com/NuGet/NuGet.Server.git", "fe2231b0373b9ecc3333a51695f8ec8864fc1368"),
( "https://github.com/ObsidianMC/Obsidian.git", "14d4ab25452f058b4f0ee0953bc30f28e4d94c29"),
( "https://github.com/ThreeMammals/Ocelot.git", "41d4f9c6dfa3069dc9035e2e82d0c46f7f08cf56"),
( "https://github.com/openiddict/openiddict-core.git", "eb35cbefb700b3f219439431aa489f555a27a5de"),
]

print(os.getcwd())

for (repo, commit_sha) in PROJECTS:
    print(f"[DEBUG] Running for repo: {repo}")
    print(f"[DEBUG] Target commit: {commit_sha}")

    os.system(f"gh repo fork {repo} --clone")
    directory = repo.split("/")[-1].replace(".git", "")
    print(directory)
    os.system(f"cd {directory} && git checkout {commit_sha}")
    