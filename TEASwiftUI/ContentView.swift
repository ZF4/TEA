import SwiftUI

struct ContentView: View {
    @State var pageIndex = 0
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool?
    @AppStorage("isOnboarding") private var isOnboarding: Bool?
    private var pages: [OnboardingItem] = OnboardingItem.pages
    private var dotAppearance = UIPageControl.appearance()
    
    var body: some View {
            TabView(selection: $pageIndex) {
                ForEach(pages, id: \.id) { page in
                    VStack {
                        Spacer()
                        OnboardingView(page: page)
                            .padding(.bottom, 25)
                        if page == pages.last {
                            Button(action: {
                                isFirstTimeLaunch = true
                                isOnboarding = false
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 200, height: 50)
                                    Text("Let's go!")
                                        .foregroundStyle(Color.white)
                                }
                                .padding(.horizontal)
                            })
                            
                        } else {
                            Button(action: {
                                incrementPage()
                            }, label: {
                                VStack {
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 40))
                                }
                                .padding(.top)
                                .padding(.horizontal)
                            })
                        }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .lightGray
                dotAppearance.pageIndicatorTintColor = .darkGray
            }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
