//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Maya Krishnan on 1/27/26.
//

import SwiftUI

struct ContentView: View {
    @State private var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course).font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .background(Color.purple).opacity(0.1)
            .sheet(isPresented: $showingAddAssignmentView) {
                AddAssignmentView()
                    .environment(assignmentList)
            }
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                    showingAddAssignmentView = true
                                    }, label: {
                                    Image(systemName: "plus")
                                            .foregroundColor(.purple)
                                            .font(.title2)
                                                    }))
        }
        .accentColor(.purple)
    }
}

#Preview {
    ContentView()
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
