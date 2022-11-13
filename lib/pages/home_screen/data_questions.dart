
class DataQuestion{
// static final List listDataQuestion=[
//   {"title":" 1. Làm thế nào để bạn ghi lại code của bạn? (How do you document your code?)","content":"Mục đích: Giúp đánh giá mindset về Clean code và khả năng viết Document của ứng viênChiến lược trả lời: Ứng viên cần đưa ra lý do cần viết Document, comment và kinh nghiệm viết bản thân "},
//   {"title":" 2. Multi-threading là gì và được sử dụng như thế nào (What is multi-threading and how is it used?)","content":"Mục đích: Đây là một câu hỏi phỏng vấn ứng viên nhằm kiểm tra kiến thức kiến trúc máy tínhChiến lược trả lời: Cần giải thích rõ khái niệm multi-threading và việc áp dụng vào trong vị trí ứng viên đang ứng tuyểnTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\"Trong kiến trúc máy tính, đa luồng là khả năng của đơn vị xử lý trung tâm (CPU) (hoặc một lõi đơn trong bộ xử lý đa lõi) cung cấp nhiều luồng thực thi đồng thời, được hỗ trợ bởi hệ điều hành.\"Tham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\"In computer architecture, multithreading is the ability of a central processing unit (CPU) (or a single core in a multi-core processor) to provide multiple threads of execution concurrently, supported by the operating system.\""},
//   {"title":" 3. Cơ sở dữ liệu NoSQL là gì? Các loại NoSQL? (What are NoSQL databases? What are the different types of NoSQL databases?)","content":"Mục đích: Đánh giá kiến thức lựa chọn CSDL phù hợp mục đích ứng dụng, hoặc làm giải pháp cho vấn đề kỹ thuật tương ứngChiến lược trả lời: Cần so sán NoSQL và SQL truyền thống và các trường hợp dùng tương ứngTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\"Cơ sở dữ liệu NoSQL là Cơ sở dữ liệu được xây dựng dành riêng cho mô hình dữ liệu và có sơ đồ linh hoạt để xây dựng các ứng dụng hiện đại. Cơ sở dữ liệu NoSQL được công nhận rộng rãi vì khả năng dễ phát triển, chức năng cũng như hiệu năng ở quy mô lớn. Các loại CSDL NoSQL:Document OrientedKey ValueGraphColumn Oriented.\"Tham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\"A NoSQL database provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases (like SQL, Oracle, etc.).Types of NoSQL databases:Document OrientedKey ValueGraphColumn Oriented\""},
//   {"title":" 4. Phân biệt  cú pháp Where và Having? (What is the difference between WHERE clause and HAVING clause?)","content":"Mục đích: Đánh giá kiến thức căn bản về DB của ứng viênChiến lược trả lời: Cần phân biệt về ý nghĩa và cú pháp của WHERE và HAVING. Ứng viên có thể nêu thêm về quá trình, thử tự xử lý câu SQL của CSDLTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\"HAVING: được sử dụng để kiểm tra các điều kiện sau khi quá trình tổng hợp diễn ra.WHERE: được sử dụng để kiểm tra các điều kiện trước khi tập hợp diễn ra.\"Tham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\"WHERE clause can only be applied on a static non-aggregated columnwe will need to use HAVING for aggregated columns.\""},
//   {"title":" 5. Dự án nhóm thử thách nhất của bạn là gì, và bạn đã vượt qua nó như thế nào? (What has been your most challenging team project, and how did you work through it?)","content":"Mục đích: Đánh giá kinh nghiệm làm việc và teamwork của ứng viênChiến lược trả lời: Ứng viên cần nêu ra một vấn đề khó khăn mà mình đã gặp phù hợp với vị trí ứng tuyển đồng thời cần thể hiện phương pháp giải quyết vấn đề chín chắn, phù hợp và đem lại kết quả dài hạn"}
// ];
static final List listDataQuestion=[
  {"title":" 1. Làm thế nào để bạn ghi lại code của bạn? (How do you document your code?)","content":"Mục đích: Giúp đánh giá mindset về Clean code và khả năng viết Document của ứng viên\nChiến lược trả lời: Ứng viên cần đưa ra lý do cần viết Document, comment và kinh nghiệm viết bản thân\n"},
  {"title":" 2. Multi-threading là gì và được sử dụng như thế nào (What is multi-threading and how is it used?)","content":"Mục đích: Đây là một câu hỏi phỏng vấn ứng viên nhằm kiểm tra kiến thức kiến trúc máy tính\nChiến lược trả lời: Cần giải thích rõ khái niệm multi-threading và việc áp dụng vào trong vị trí ứng viên đang ứng tuyển\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\n\"Trong kiến trúc máy tính, đa luồng là khả năng của đơn vị xử lý trung tâm (CPU) (hoặc một lõi đơn trong bộ xử lý đa lõi) cung cấp nhiều luồng thực thi đồng thời, được hỗ trợ bởi hệ điều hành.\"\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\n\"In computer architecture, multithreading is the ability of a central processing unit (CPU) (or a single core in a multi-core processor) to provide multiple threads of execution concurrently, supported by the operating system.\""},
  {"title":" 3. Cơ sở dữ liệu NoSQL là gì? Các loại NoSQL? (What are NoSQL databases? What are the different types of NoSQL databases?)","content":"Mục đích: Đánh giá kiến thức lựa chọn CSDL phù hợp mục đích ứng dụng, hoặc làm giải pháp cho vấn đề kỹ thuật tương ứng\nChiến lược trả lời: Cần so sán NoSQL và SQL truyền thống và các trường hợp dùng tương ứng\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\n\"Cơ sở dữ liệu NoSQL là Cơ sở dữ liệu được xây dựng dành riêng cho mô hình dữ liệu và có sơ đồ linh hoạt để xây dựng các ứng dụng hiện đại. Cơ sở dữ liệu NoSQL được công nhận rộng rãi vì khả năng dễ phát triển, chức năng cũng như hiệu năng ở quy mô lớn. Các loại CSDL NoSQL:\nDocument Oriented\nKey Value\nGraph\nColumn Oriented.\"\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\n\"A NoSQL database provides a mechanism for storage and retrieval of data that is modeled in means other than the tabular relations used in relational databases (like SQL, Oracle, etc.).Types of NoSQL databases:\nDocument Oriented\nKey Value\nGraph\nColumn Oriented\""},
  {"title":" 4. Phân biệt  cú pháp Where và Having? (What is the difference between WHERE clause and HAVING clause?)","content":"Mục đích: Đánh giá kiến thức căn bản về DB của ứng viên\nChiến lược trả lời: Cần phân biệt về ý nghĩa và cú pháp của WHERE và HAVING. Ứng viên có thể nêu thêm về quá trình, thử tự xử lý câu SQL của CSDL\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Việt:\n\"HAVING: được sử dụng để kiểm tra các điều kiện sau khi quá trình tổng hợp diễn ra.\nWHERE: được sử dụng để kiểm tra các điều kiện trước khi tập hợp diễn ra.\"\n\nTham khảo câu trả lời phỏng vấn mẫu bằng Tiếng Anh:\n\"WHERE clause can only be applied on a static non-aggregated column\nwe will need to use HAVING for aggregated columns.\""},
  {"title":" 5. Dự án nhóm thử thách nhất của bạn là gì, và bạn đã vượt qua nó như thế nào? (What has been your most challenging team project, and how did you work through it?)","content":"Mục đích: Đánh giá kinh nghiệm làm việc và teamwork của ứng viên\nChiến lược trả lời: Ứng viên cần nêu ra một vấn đề khó khăn mà mình đã gặp phù hợp với vị trí ứng tuyển đồng thời cần thể hiện phương pháp giải quyết vấn đề chín chắn, phù hợp và đem lại kết quả dài hạn"}];
}