import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @FocusState private var isInputActive: Bool?
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer(minLength: geometry.size.height * 0.2) // 使顶部空间基于设备屏幕的大小
                    
                    VStack(spacing: 20) {
                        // Logo或应用名称
                        Text("HappyDay")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(isInputActive == true ? 0.9 : 1.0)
                            .animation(.easeInOut, value: isInputActive)
                        
                        // 输入框
                        VStack(spacing: 15) {
                            TextField("Username", text: $username)
                                .focused($isInputActive, equals: true)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            SecureField("Password", text: $password)
                                .focused($isInputActive, equals: true)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .autocapitalization(.none)
                        }
                        .padding(.horizontal)
                        .animation(.easeInOut, value: isInputActive)
                        
                        // 登录按钮
                        Button("Log In") {
                            // 处理登录操作
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .scaleEffect(isInputActive == true ? 0.96 : 1.0)
                        .animation(.spring(), value: isInputActive)
                        
                        // 附加链接或信息
                        VStack {
                            HStack {
                                Text("Don't have an account?")
                                Button("Sign Up") {
                                    // 处理注册操作
                                }
                            }
                            HStack {
                                Text("Forgot Password?")
                                Button("Reset") {
                                    // 处理密码重置
                                }
                            }
                        }
                        .font(.footnote)
                        .foregroundColor(.blue)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                    Spacer(minLength: geometry.size.height * 0.2) // 增加底部空间以使内容上移
                }
                .onTapGesture {
                    // 点击非输入区域隐藏键盘
                    isInputActive = nil
                }
                .padding(.top)
                .background(Color(.systemGray5).edgesIgnoringSafeArea(.all))
            }
            // .navigationTitle("") // 完全移除标题
        }
        .padding(0.0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
