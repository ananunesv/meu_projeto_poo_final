// Zen Mind - JavaScript Principal
// Funcionalidades elegantes e práticas para o app de meditação

document.addEventListener('DOMContentLoaded', function() {
    console.log('🧘 Zen Mind inicializando...');
    
    // ===== NAVEGAÇÃO SUAVE =====
    const initSmoothScroll = () => {
        // Todos os links internos
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);
                
                if (targetElement) {
                    // Calcula posição considerando altura do nav
                    const navHeight = document.querySelector('nav').offsetHeight;
                    const targetPosition = targetElement.offsetTop - navHeight - 20;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                    
                    console.log(`📍 Navegando para ${targetId}`);
                }
            });
        });
    };
    
    // ===== EFEITO SCROLL NA NAVBAR =====
    const initNavScroll = () => {
        const nav = document.querySelector('nav');
        
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                nav.classList.add('scrolled');
            } else {
                nav.classList.remove('scrolled');
            }
        });
    };
    
    // ===== MENU MOBILE =====
    const initMobileMenu = () => {
        const menuBtn = document.querySelector('.mobile-menu-btn');
        const navLinks = document.querySelector('.nav-links');
        
        // Cria menu mobile se não existir
        let mobileMenu = document.querySelector('.mobile-menu');
        if (!mobileMenu) {
            mobileMenu = document.createElement('div');
            mobileMenu.className = 'mobile-menu';
            mobileMenu.innerHTML = `
                <ul class="mobile-links">
                    ${navLinks.innerHTML}
                </ul>
            `;
            document.body.appendChild(mobileMenu);
        }
        
        // Toggle menu
        menuBtn.addEventListener('click', () => {
            menuBtn.classList.toggle('active');
            mobileMenu.classList.toggle('active');
            
            // Anima botão hambúrguer
            const spans = menuBtn.querySelectorAll('span');
            if (menuBtn.classList.contains('active')) {
                spans[0].style.transform = 'rotate(45deg) translate(5px, 5px)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'rotate(-45deg) translate(5px, -5px)';
            } else {
                spans[0].style.transform = '';
                spans[1].style.opacity = '';
                spans[2].style.transform = '';
            }
        });
        
        // Fecha menu ao clicar em link
        mobileMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                menuBtn.classList.remove('active');
                mobileMenu.classList.remove('active');
            });
        });
    };
    
    // ===== ANIMAÇÃO DO CÍRCULO DE RESPIRAÇÃO =====
    const initBreathingAnimation = () => {
        const breathingText = document.querySelector('.breathing-text');
        if (!breathingText) return;
        
        const texts = ['Inspire...', 'Segure...', 'Expire...', 'Pause...'];
        let index = 0;
        
        setInterval(() => {
            breathingText.style.opacity = '0';
            setTimeout(() => {
                breathingText.textContent = texts[index];
                breathingText.style.opacity = '1';
                index = (index + 1) % texts.length;
            }, 300);
        }, 4000 / texts.length);
    };
    
    // ===== ANIMAÇÕES AO SCROLL =====
    const initScrollAnimations = () => {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                    
                    // Anima cards em sequência
                    if (entry.target.classList.contains('feature-card')) {
                        const cards = document.querySelectorAll('.feature-card');
                        cards.forEach((card, index) => {
                            setTimeout(() => {
                                card.style.opacity = '1';
                                card.style.transform = 'translateY(0)';
                            }, index * 100);
                        });
                    }
                }
            });
        }, observerOptions);
        
        // Observa elementos
        const animatedElements = document.querySelectorAll(
            '.feature-card, .pricing-card, .section-header'
        );
        
        animatedElements.forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'all 0.6s ease';
            observer.observe(el);
        });
    };
    
    // ===== BOTÃO SCROLL TO TOP =====
    const initScrollToTop = () => {
        const scrollBtn = document.querySelector('.scroll-top');
        
        // Mostra/esconde botão
        window.addEventListener('scroll', () => {
            if (window.scrollY > 300) {
                scrollBtn.classList.add('visible');
            } else {
                scrollBtn.classList.remove('visible');
            }
        });
        
        // Clique para voltar ao topo
        scrollBtn.addEventListener('click', () => {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    };
    
    // ===== INTERAÇÕES DOS PLANOS =====
    const initPricingInteractions = () => {
        const pricingCards = document.querySelectorAll('.pricing-card');
        
        pricingCards.forEach(card => {
            card.addEventListener('mouseenter', () => {
                // Diminui opacidade dos outros cards
                pricingCards.forEach(otherCard => {
                    if (otherCard !== card) {
                        otherCard.style.opacity = '0.7';
                    }
                });
            });
            
            card.addEventListener('mouseleave', () => {
                // Restaura opacidade
                pricingCards.forEach(otherCard => {
                    otherCard.style.opacity = '1';
                });
            });
        });
        
        // Botões dos planos
        const planButtons = document.querySelectorAll('.plan-btn');
        planButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const planName = btn.closest('.pricing-card').querySelector('.plan-name').textContent;
                console.log(`💳 Plano selecionado: ${planName}`);
                alert(`Você selecionou o plano ${planName}! 🎉`);
            });
        });
    };
    
    // ===== ESTATÍSTICAS ANIMADAS =====
    const animateStats = () => {
        const stats = document.querySelectorAll('.stat-number');
        
        stats.forEach(stat => {
            const finalValue = stat.textContent;
            const isRating = finalValue.includes('⭐');
            const numericValue = parseFloat(finalValue.replace(/[^0-9.]/g, ''));
            const suffix = finalValue.replace(/[0-9.]/g, '');
            
            // Anima do 0 ao valor final
            let currentValue = 0;
            const increment = numericValue / 50; // 50 steps
            const timer = setInterval(() => {
                currentValue += increment;
                
                if (currentValue >= numericValue) {
                    currentValue = numericValue;
                    clearInterval(timer);
                }
                
                if (isRating) {
                    stat.textContent = currentValue.toFixed(1) + suffix;
                } else {
                    stat.textContent = Math.floor(currentValue) + suffix;
                }
            }, 30);
        });
    };
    
    // ===== EFEITO PARALLAX SUTIL =====
    const initParallax = () => {
        const floatingElements = document.querySelectorAll('.float-element');
        
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            
            floatingElements.forEach((element, index) => {
                const speed = 0.5 + (index * 0.1);
                element.style.transform = `translateY(${scrolled * speed * 0.1}px)`;
            });
        });
    };
    
    // ===== VALIDAÇÃO SIMPLES DO FORMULÁRIO =====
    const initDownloadButtons = () => {
        const downloadBtns = document.querySelectorAll('.store-btn');
        
        downloadBtns.forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const store = btn.querySelector('img').alt;
                console.log(`📱 Redirecionando para ${store}`);
                
                // Simula redirecionamento
                alert(`Você seria redirecionado para a ${store}! 📲`);
            });
        });
    };
    
    // ===== EASTER EGG SIMPLES =====
    const initEasterEgg = () => {
        let clickCount = 0;
        const logo = document.querySelector('.logo');
        
        logo.addEventListener('click', () => {
            clickCount++;
            
            if (clickCount === 5) {
                console.log('🎉 Easter egg ativado!');
                document.body.style.animation = 'rainbow 3s ease-in-out';
                
                // Remove animação após 3 segundos
                setTimeout(() => {
                    document.body.style.animation = '';
                }, 3000);
                
                clickCount = 0;
            }
        });
        
        // Adiciona keyframe para easter egg
        const style = document.createElement('style');
        style.textContent = `
            @keyframes rainbow {
                0% { filter: hue-rotate(0deg); }
                100% { filter: hue-rotate(360deg); }
            }
        `;
        document.head.appendChild(style);
    };
    
    // ===== CONSOLE LOGS INFORMATIVOS =====
    const logSystemInfo = () => {
        console.log('📊 Zen Mind - Sistema de Informações:');
        console.log('✅ Smooth scroll ativo');
        console.log('✅ Animações de scroll ativas');
        console.log('✅ Menu mobile pronto');
        console.log('✅ Interações de UI carregadas');
        console.log('💡 Dica: Clique 5x no logo para uma surpresa!');
    };
    
    // ===== INICIALIZAÇÃO =====
    const init = () => {
        initSmoothScroll();
        initNavScroll();
        initMobileMenu();
        initBreathingAnimation();
        initScrollAnimations();
        initScrollToTop();
        initPricingInteractions();
        initParallax();
        initDownloadButtons();
        initEasterEgg();
        
        // Anima estatísticas quando aparecem
        setTimeout(animateStats, 1000);
        
        // Logs do sistema
        logSystemInfo();
        
        console.log('🧘 Zen Mind totalmente carregado e funcional!');
    };
    
    // Inicia tudo
    init();
});

// ===== ESTILOS DINÂMICOS PARA MOBILE MENU =====
const mobileMenuStyles = `
    .mobile-menu {
        position: fixed;
        top: 70px;
        left: 0;
        width: 100%;
        background: rgba(255, 255, 255, 0.98);
        backdrop-filter: blur(10px);
        transform: translateY(-100%);
        transition: transform 0.3s ease;
        z-index: 999;
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
    }
    
    .mobile-menu.active {
        transform: translateY(0);
    }
    
    .mobile-links {
        list-style: none;
        padding: 2rem;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }
    
    .mobile-links a {
        color: var(--text-primary);
        text-decoration: none;
        font-size: 1.1rem;
        font-weight: 500;
    }
`;

// Adiciona estilos ao documento
const styleSheet = document.createElement('style');
styleSheet.textContent = mobileMenuStyles;
document.head.appendChild(styleSheet);

// Mensagem final
console.log('🌟 Bem-vindo ao Zen Mind - Encontre sua paz interior!');