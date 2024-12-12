# 📡 UDP Hole Punching Tool

This repository showcases a **Delphi-based UDP Hole Punching Tool** using Indy components. The tool combines both server and client functionalities in one application, allowing you to configure the role (Server or Client) and perform UDP-based communication between two PCs.

![Preview](Preview.png)

## 📋 Project Overview
- **Unified Application**: A single Delphi application where you can switch between server and client roles for UDP communication.
- **Server Mode**: Listens for incoming UDP packets and manages communication with the client.
- **Client Mode**: Sends messages to the server and receives responses, supporting both broadcast and private messages.

## ✨ Features
- **Role Selection**: Choose between "Your PC" or "Another PC" to configure the appropriate UDP ports.
- **UDP Communication**: Enables real-time messaging between client and server.
- **Real-time Logging**: Display messages exchanged between client and server in the log interface.
- **Dynamic Ports**: Automatically adjusts the ports based on the selected role.

## ⚙️ Installation
1. **Requirements**: Delphi IDE and Indy components.
2. **Clone & Open Project**: Clone the repository and open the `.dpr` files in Delphi.
3. **Compile**: Build the application which includes both server and client functionality.
4. **Run**: Start the application and switch between server and client roles.

## 🔌 Usage
1. **Role Selection**: Select "Your PC" or "Another PC" to configure the correct ports for server and client.
2. **Start Server**: Launch the server to listen for incoming connections on the configured port.
3. **Client Connection**: Enter the server's IP address, select your role, and connect to the server.
4. **Messaging**: 
    - **Broadcast**: Send messages from the client to all connected clients.
    - **Private Messaging**: Send messages to a specific client by selecting them from the list.
5. **Disconnection**: Disconnect by closing the application.

## 🤝 Contributing
Fork the repository, make improvements, and submit a pull request for review.

## 📜 License
This project is open-source and distributed under the MIT License.

## 📧 Contact
For any questions or feedback, open an issue or email us directly.

<p align="center">Built with ❤️ By BitmasterXor using Delphi and Indy Components</p>
