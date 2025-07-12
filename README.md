# README

# participatory_budgeting
Steps to Run Locally
Clone the repository:

bash
git clone <your-repo-url>
cd participatory_budgeting
Install dependencies:

bash
bundle install
yarn install # if using webpacker
Set up the database:

bash
rails db:create
rails db:migrate
rails db:seed
Run the server:

bash
rails server
Visit in browser:

Home: http://localhost:3000/

Register: http://localhost:3000/users/sign_up

Login: http://localhost:3000/users/sign_in

Allocate: http://localhost:3000/allocations/new

Admin Report: http://localhost:3000/admin/report (as admin)