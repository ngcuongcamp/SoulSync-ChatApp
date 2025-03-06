## Clean Architecture: giúp tách biệt các tầng lớp trong ứng dụng 

### 1. `Data Layer(data/)`: chịu trách nghiệm lấy và xử lý dữ liệu từ nguồi khác nhau (API, database, local storage)

#### 1.1 `data/datasource/`: chứa các nguồn dữ liệu (remote/local)
- **`data/datasource/auth_remote_datasource.dart`**: lấy dữ liệu từ API 
- **`data/datasource/auth_local_datasource.dart`**: lưu trữ thông tin người dùng cục bộ 

#### 1.2 `data/models/`: chứa các model dữ liệu, thường ánh xạ từ JSON của API 
- **`data/models/user_model.dart`**: chứa thông tin người udng, chuyển đổi từ JSON


#### 1.3 `data/repositories/`: cài đặt cụ thể của repository, kết nối `data/datasource` và `domain/repositories`

- **`data/repositories/auth_repository_impl.dart`**: 
    + nó thực hiện các phương thức được định nghĩa trong interface **`data/repositories/auth_repository.dart`** của tầng `domain`
    + nó kết nối tầng `domain` và `data`, giúp `domain layer` không phụ thuộc vào các dữ liệu được lấy từ (API, database,...)
    + gọi `datasource` để lấy dữ liệu, xử lý nếu cần rồi trả về tầng `domain`
    + `đóng vai trò trung gian`, giúp việc thay đổi nguồn dữ liệu (`API mới, database mới`) mà không ảnh hưởng đến `domain layer`


<!-- ###################################################### -->
### 2. Domain Layer (`domain/`): là tầng trung gian, chỉ chứa logic nghiệp vụ, không phụ thuộc và data hay UI 

#### 2.1 `domain/entities/`: định nghĩa các đối tượng cốt lõi, không phụ thuộc vào Framework 
- **`domain/entities/user.dart`**:  (Chứa các thuộc tính cơ bản như id, name, email)

#### 2.2 `domain/repositories/`: định nghĩa các giao diện `repository` mà tầng `data` sẽ `implement`(thực hiện)
- **`domain/repositories/auth_respository.dart`**: Interface cho auth_repository_impl.dart

#### 2.3 `domain/usecases`: chứa các logic nghiệp vục (business logic)
- **`domain/usecases/login_usecase.dart`**
- **`domain/usecases/register_usecase.dart`**

<!-- ########################################## -->

### 3. Presentation Layer (`presentation/`): chứa UI và state management
#### 3.1 `presentation/bloc`: chứa logic quản lý trạng thái bằng `Bloc`

- **`presentation/bloc/auth_bloc.dart`**: xử lý logic đăng nhập 
    + tập hợp sự kiện (`event`) và trả về trạng thái (`state`) tương ứng 
- **`presentation/bloc/auth_event.dart`**: định nghĩa các sự kiện
- **`pressentation.bloc/auth_state.dart`**: định nghĩa các trạng thái (`state`)

#### 3.2 `presentation/widget/`: chứa các widget tái sử dụng
#### 3.3 `presentation/pages/`: các trang thuộc auth feature