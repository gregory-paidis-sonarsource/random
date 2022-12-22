$repos = $(
    "gregory-paidis-sonarsource/akka.net", 
    "gregory-paidis-sonarsource/Fody", 
    "gregory-paidis-sonarsource/AutoMapper"
)

foreach ($repo in $repos) {
    gh repo delete $repo --confirm
}

