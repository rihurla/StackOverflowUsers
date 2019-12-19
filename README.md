# StackOverflowUsers
App created to display users from StackOverflow. :)

### Running Tests
To run the tests on Xcode, select the StackOverflowUsers target and device, and click on the Test option or press ⌘+U

### Building App
There is no third party dependencies on this app, just press ⌘+R

### App Structure
Design - Helpers and wrappers related to the UI elements
Extensions - Extensions created to facilitate the encapsulate common functionality
Management - Managers for dependencies that can be used globally across the App
Models - Codable Model objects
Service - API services and helpers
Storage - Local simulation of user state
View - ViewControllers, ViewModels and TableViewCells

*Test files and folders are organised in the same pattern of the production files and folders

### Design/Architecture
This project adopts MVVM and can be extended to use Coordinators/Routers.
In order to make the business logic testable, the viewModels and Services are accessed via Protocol with mocks included on the test target.

## Author
* **Ricardo Hurla** - [Portfolio](https://rihurla.com)  -  [BitBucket](https://bitbucket.org/rihurla/)  -  [Github](https://github.com/rihurla) - [Phone](0118 999 881 999 119 725 3)
