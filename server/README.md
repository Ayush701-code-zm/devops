# Task Manager Server

## Setup Instructions

1. **Install Dependencies:**
   ```bash
   npm install
   ```

2. **Environment Configuration:**
   - Copy `env.template` to `.env`
   - Update the `MONGODB_URI` in `.env` with your database connection string

3. **Database Options:**
   
   **Option A: Local MongoDB**
   ```
   MONGODB_URI=mongodb://localhost:27017/taskmanager
   ```
   
   **Option B: MongoDB Atlas**
   ```
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/taskmanager?retryWrites=true&w=majority
   ```

4. **Run the Server:**
   ```bash
   # Development mode (with file watching)
   npm run dev
   
   # Production mode
   npm start
   ```

## Current Status

✅ Server is running on port 5000  
⚠️  MongoDB connection needs to be configured

To fix the MongoDB connection:
1. Either install MongoDB locally, or
2. Set up MongoDB Atlas and whitelist your IP address
3. Update the `.env` file with the correct connection string
