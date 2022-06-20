//
//  ContentView.swift
//  news
//
//  Created by Giuseppe Maiarù on 19/06/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm : HomeViewModel
    
    fileprivate func listRow(_ article: Article) -> some View {
        Navigator.navigate(.detail(article)) {
            VStack{
                Text(article.title).font(.title)
                HStack{
                    AsyncImage(
                        url: article.imageUrl,
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 100, maxHeight: 100)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    Text("\(article.description)").lineLimit(3)
                }
            }
            
        }
        
    }

    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white).padding(EdgeInsets.init(top: 14, leading: 8, bottom: 14, trailing: 0))
            
            TextField("Search", text: $vm.searchQuery)
                .foregroundColor(Color.white)
                .padding(
                    EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
                )
                .font(.system(size:14))
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding(
            EdgeInsets.init(top: 0, leading: 16, bottom: 8, trailing: 16)
        )
    }
    
    fileprivate func NewsList() -> some View {
        VStack{
            searchBar
            
            List {
                ForEach(vm.news){ item in
                    listRow(item)
                }
            }
            .navigationTitle("News List")
            /*.task {
                await vm.fetchNews()
            }*/
            .alert("Error", isPresented: $vm.hasError) {
            } message: {
                Text(vm.errorMessage)
            }
        }
        
    }
    
    var body: some View {
        NavigationView{
            NewsList()
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(vm: NewsViewModel())
//    }
//}
