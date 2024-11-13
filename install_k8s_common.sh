

swapoff -a
sed -i '/swap/d' /etc/fstab
swapon -s

cat >>/etc/modules-load.d/crio.conf<<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
lsmod | grep overlay
lsmod | grep br_netfilter
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl pgp
sudo mkdir /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt install -y kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
