

# Mango - Refactor Schema stored in JSON files

**Introduction**

- This app allows updating schema of JSON files spread across filestystem

- This was originally built to manage test data used with wiremock.





### 1. Setup

```shell
git clone https://github.com/nishants/mango.git
cd mango
bundle install
```



### 2. Run server

```
ruby src/server/run.rb
```



### 3. Create project

- Enter the absolute path of root folder containing all json files
- This will create a mango.json file in the project root
![Create project](<https://raw.githubusercontent.com/nishants/mango/master/docs/images/01-add-project.png>)


### 4. Edit name and add description for project
- This allows you manage different projects
- For e.g. test data for app-1, test data for app-2
![Edit project](<https://raw.githubusercontent.com/nishants/mango/master/docs/images/02-edit-project.png>)

###  5. Browse JSON files in editor
- 
![Edit project](<https://raw.githubusercontent.com/nishants/mango/master/docs/images/03-browse-files.png>)

###  6. Update schema and preview changes
- Change the json field name in one of the file and click on **UpdateSchema** button on top
- You will see a prompt with names of all files that will be updated
- Also you will see the changes that will be applied to all the files
- Click on **Proceed** button to apply changes to all files.

![Edit project](<https://raw.githubusercontent.com/nishants/mango/master/docs/images/04-updpate-schema.png>)

**Develop**

```shell
# compile scss
scss --watch public/css/style.scss:public/css/style.css

# run tests
rspec test/

# view test reports 
open client-tests.html
```





