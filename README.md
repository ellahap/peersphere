# Introduction
## What is PeerSphere?

PeerSphere is your collaborative campus hub — a peer-to-peer learning platform where students can share resources (notes, slides, etc.), ask and answer questions, and plan study sessions together.  You can access our site [here](https://peersphere-i9nx.onrender.com/).

Below is a walk-through of our site, and its core features.

https://github.com/user-attachments/assets/7e964512-4e93-4ede-9558-55eb1cd6068c

Our platform constructs a centralized space in which students can:

1. Create or join study groups
2. Share and upload course materials (PDFs, slides, flashcards, etc.)
3. View and upvote/downvote material
4. Post availability and organize study sessions
5. Schedule sessions with Google Calendar
6. Access Q&A threads for class-specific discussion

For more details, view the project proposal [here](https://docs.google.com/document/d/11f3lOFnXMaBw-NN4dJJ-7CEKo8AYfa4VUUXHrnAEsXo/edit?tab=t.0).


# Technical Architecture

<img width="744" height="375" alt="439974083-bf3a8661-114b-4851-ae41-0652adb932f3" src="https://github.com/user-attachments/assets/a8b849b3-7e8b-4caf-a8db-14fc8b95feb5" />


- Frontend: HTML, CSS, and JavaScript
- Backend: Node.js with Express.js
- Database: PostgreSQL on AWS RDS
- APIs: Google Calendar API integration



# Developers
- **Shreya Gangulya**: Frontend development, UI/UX design, Q&A page
- **Adhwita Gopi Selvan**: Uploading and downloading content, adding reactions, test case writing
- **Ella Happel**: Backend functionality and database
- **Shivani Dudyala**: Google Calendar API Integration and scheduling



# Environment Setup
## Installing Dependencies
From the root directory of the project:
```
npm install
```

## Running the Project Locally
```
node server.js
```
Go to: [http://localhost:3000](http://localhost:3000)



# Development
## Testing
- Frontend tested through browser-based interaction and automated UI testing.
- Backend endpoints manually tested with mock inputs.
- Project makes use of GitHub branches and group PR review.
- Manual feature testing between each PR.



# Project Instructions
## Signup/Login
- Access / for logging in
- New users can sign up at /signup
- User sessions tracked via cookies

## Study Group Management
- Join or add study groups via group codes
- Group data stored in PostgreSQL (study_groups, memberships)

## Resource Upload & Download
- Upload PDFs, PPTs, images
- Reactions supported: 👍 (likes) and ❤️ (hearts)
- Download of files uploaded by users is supported
- Tracks and displays date, title, type, and creator of upload
  
## Q&A Discussion
- There is a distinct Q&A thread for every group
- Users can create and respond to questions
- Users can upvote and downvote answers
  
## Scheduling & Availability
- Students can add their availability by using a graphical weekly grid
- Visual overlaps are marked
- Events can be created and sent to Google Calendar
