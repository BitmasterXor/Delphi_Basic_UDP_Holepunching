# 📡 UDP Hole Punching Tool

This repository showcases a Delphi-based **UDP Hole Punching Tool** utilizing Indy components. It enables UDP-based communication between two PCs, with features for role selection and real-time message sending.

![Preview](Preview.png)

## 📋 Project Overview
- **Server Application**: Listens for incoming UDP packets and manages communication with clients.
- **Client Application**: Sends messages to the server and receives responses, with periodic status updates.

## ✨ Features
- **Role Selection**: Choose between "Your PC" or "Another PC" for configuring UDP ports.
- **UDP Communication**: Send and receive messages between client and server.
- **Real-time Logging**: View messages exchanged through a detailed log interface.
- **Dynamic Ports**: Adjusts server/client ports based on selected roles.

## ⚙️ Installation
1. **Requirements**: Delphi IDE and Indy components.
2. **Clone & Open Project**: Clone the repository and open `.dpr` files in Delphi.
3. **Compile**: Build the server and client applications.
4. **Run**: Start the server and connect using the client.

## 🔌 Usage
1. **Server Setup**: Launch the server and listen for connections on configured ports.
2. **Client Connection**: Enter the server’s IP address, select the role, and start communication.
3. **Messaging**: 
    - **Broadcast**: Server sends messages to all clients.
    - **Private Messaging**: Specific messages to selected clients.
4. **Disconnection**: Gracefully disconnect by closing the client application.

## 🤝 Contributing
Fork, modify, and submit a pull request for improvements!

## 📜 License
This project is open-source under the MIT License.

## 📧 Contact
For feedback or questions, open an issue or email us directly.

<p align="center">Built with ❤️ By BitmasterXor using Delphi and Indy Components</p>
