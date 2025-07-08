# ChatAPP

A simple chat application with a Spring Boot backend and React frontend.

## Features

- Chat interface with a virtual assistant
- Real-time message display
- Error handling
- Responsive design for mobile and desktop

## Technology Stack

### Backend
- Java 17
- Spring Boot 3.5.3
- LangChain4j with Google AI Gemini integration

### Frontend
- React 18
- Axios for API communication
- CSS for styling

## Project Structure

```
ChatAPP/
├── src/
│   ├── main/
│   │   ├── frontend/         # React frontend
│   │   ├── java/             # Java backend
│   │   └── resources/        # Application properties
│   └── test/                 # Test files
└── pom.xml                   # Maven configuration
```

## Getting Started

### Prerequisites

- Java 17 or higher
- Maven
- Node.js and npm (automatically installed by Maven during build)
- Google AI Gemini API key

### Environment Variables

Set the following environment variable:

```
GEMINI_API_KEY=your_gemini_api_key
```

### Building the Application

```bash
mvn clean install
```

This will:
1. Compile the Java code
2. Install Node.js and npm
3. Install frontend dependencies
4. Build the React frontend
5. Package everything into a single JAR file

### Running the Application

```bash
java -jar target/ChatAPP-0.0.1-SNAPSHOT.jar
```

Or using Maven:

```bash
mvn spring-boot:run
```

The application will be available at http://localhost:8080

## Development

### Running the Backend Separately

```bash
mvn spring-boot:run
```

### Running the Frontend Separately

```bash
cd src/main/frontend
npm install
npm start
```

The development server will start at http://localhost:3000 and proxy API requests to the backend at http://localhost:8080.

## API Endpoints

- `GET /api/v1/assistant/chat?message=<message>` - Send a message to the assistant and get a response