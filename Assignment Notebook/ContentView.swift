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
                                    .font(.headline)
                                    .foregroundColor(.purple)
                                Text(item.description)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            Text(item.dueDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onMove(perform: { indices, newOffset in
                        assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .onDelete(perform: { indexSet in
                        assignmentList.items.remove(atOffsets: indexSet)
                    })
                }
                .scrollContentBackground(.hidden)
                .background(Color.purple.opacity(0.1).ignoresSafeArea())
                .sheet(isPresented: $showingAddAssignmentView) {
                    AddAssignmentView()
                        .environment(assignmentList)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Assignment Notebook")
                            .font(.custom("Pacifico", size: 27))
                            .foregroundColor(.purple)
                    }
                }
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
