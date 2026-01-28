//
//  AddAssignmentView.swift
//  Assignment Notebook
//
//  Created by Maya Krishnan on 1/28/26.
//

import SwiftUI

struct AddAssignmentView: View {
    @Environment(AssignmentList.self) var assignmentList
    @Environment(\.dismiss) var dismiss
    static let courses = ["Algebra", "History", "Science", "Chinese", "Calculus", "English", "Mobile Apps"]
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0, description.count > 0 {
                    let item = AssignmentItem(course: course, description: description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    dismiss()
                }
            })
        }
    }
}
