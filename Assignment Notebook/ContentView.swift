//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Maya Krishnan on 1/27/26.
//

import SwiftUI

struct ContentView: View {
    @State private var assignmentItems =
    [AssignmentItem(course: "Algebra", description: "Linear Equation", dueDate: Date()),
     AssignmentItem(course: "History", description: "Civil War Paper", dueDate: Date()),
     AssignmentItem(course: "Science", description: "Atomic Bomb Lab", dueDate: Date())]
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentItems) { item in
                    Text(item.description)
                }
                .onMove(perform: { indices, newOffset in
                    assignmentItems.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentItems.remove(atOffsets: indexSet)
                })
                .navigationBarItems(leading: EditButton())
            }
        }
        .navigationBarTitle("Assignment Notebook", displayMode: .inline)
    }
}

#Preview {
    ContentView()
}

struct AssignmentItem: Identifiable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}
