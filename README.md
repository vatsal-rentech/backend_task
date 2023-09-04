## endpoints

'/admin/' --> admin panel username: admin , password: 1234

0. '/create-group/' method=post, body = ['name']
                    (first create teacher and then create student group)


1. '/registration/' method = post, body = ['username', 'email', 'password' , 'user_group':[1 or 2]] (1: teacher & 2:student)


2. '/login/' method = post, body = ['username','password'], Response = JWT token


3. '/teacher-assignment/' method = get, Response = all assignment created by the logged in teacher

                          method = post, body = ['assignment_name', 'assignment_description','assignment_due_date','assignment_score']
                            - This assignment will be assigned to all available students & email will be sent to them

                          method = patch , body=['assignment_name', 'assignment_description','assignment_due_date','assignment_score']
                                                                    (Any of these can be update)


4. '/student-assignment/' method = get, Response = all assignment that are enrolled

                          method = post, body = ['id','assign_student_answer'] 
                                                (only student can submit)

                          method = patch, body = ['id','assignment_obtain_score']
                                                (only teachers can do this)


5. '/student-reports/' method = get, Response = get all the asiignment's scores


5. '/teacher-reports/' method = get, Response = get all the asiignment's details created by logged in teacher and graded