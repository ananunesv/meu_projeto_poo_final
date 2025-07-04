// Zen Mind - Homepage JavaScript

document.addEventListener('DOMContentLoaded', function() {
    console.log('🧘 Zen Mind Homepage carregada');
    
    // ===== ANIMAÇÃO DOS NÚMEROS =====
    const animateNumbers = () => {
        const numbers = document.querySelectorAll('.stat-number');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const element = entry.target;
                    const target = parseInt(element.getAttribute('data-target'));
                    let current = 0;
                    const increment = target / 100;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        element.textContent = Math.floor(current).toLocaleString('pt-BR');
                    }, 20);
                    observer.unobserve(element);
                }
            });
        });
        
        numbers.forEach(number => observer.observe(number));
    };
    
    // ===== ANIMAÇÃO DE ENTRADA =====
    const animateOnScroll = () => {
        const elements = document.querySelectorAll('.feature-card, .step-card, .testimonial-card');
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '0';
                        entry.target.style.transform = 'translateY(20px)';
                        entry.target.style.transition = 'all 0.6s ease';
                        
                        setTimeout(() => {
                            entry.target.style.opacity = '1';
                            entry.target.style.transform = 'translateY(0)';
                        }, 100);
                    }, index * 100);
                    
                    observer.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.1
        });
        
        elements.forEach(element => {
            element.style.opacity = '0';
            observer.observe(element);
        });
    };
    
    // ===== EFEITO HOVER NOS CARDS =====
    const addHoverEffects = () => {
        const cards = document.querySelectorAll('.stat-card, .feature-card, .step-card');
        
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
    };
    
    // ===== SMOOTH SCROLL PARA SEÇÕES =====
    const smoothScroll = () => {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    };
    
    // ===== EFEITO PARALLAX SUAVE =====
    const parallaxEffect = () => {
        const heroIcon = document.querySelector('.hero-icon');
        
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const speed = 0.5;
            
            if (heroIcon) {
                heroIcon.style.transform = `translateY(${scrolled * speed}px)`;
            }
        });
    };
    
    // ===== ANIMAÇÃO DO BOTÃO CTA =====
    const pulseAnimation = () => {
        const ctaButtons = document.querySelectorAll('.cta-section .btn-white');
        
        ctaButtons.forEach(button => {
            setInterval(() => {
                button.style.animation = 'pulse 1s ease-in-out';
                setTimeout(() => {
                    button.style.animation = '';
                }, 1000);
            }, 5000);
        });
    };
    
    // ===== MENSAGEM DE BOAS-VINDAS =====
    const showWelcomeMessage = () => {
        const isFirstVisit = !localStorage.getItem('zenMindVisited');
        
        if (isFirstVisit) {
            setTimeout(() => {
                console.log('🎉 Primeira visita detectada!');
                // Poderia mostrar um modal de boas-vindas aqui
                localStorage.setItem('zenMindVisited', 'true');
            }, 2000);
        }
    };
    
    // ===== LAZY LOADING DE IMAGENS =====
    const lazyLoadImages = () => {
        const images = document.querySelectorAll('img[data-src]');
        
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.add('loaded');
                    imageObserver.unobserve(img);
                }
            });
        });
        
        images.forEach(img => imageObserver.observe(img));
    };
    
    // ===== TOOLTIP NOS ÍCONES =====
    const addTooltips = () => {
        const icons = document.querySelectorAll('.feature-icon, .stat-icon');
        
        icons.forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                const tooltip = document.createElement('div');
                tooltip.className = 'tooltip';
                tooltip.textContent = 'Clique para saber mais';
                tooltip.style.cssText = `
                    position: absolute;
                    background: #333;
                    color: white;
                    padding: 0.5rem 1rem;
                    border-radius: 5px;
                    font-size: 0.875rem;
                    pointer-events: none;
                    transform: translateY(-100%);
                    margin-top: -10px;
                    white-space: nowrap;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                `;
                
                this.appendChild(tooltip);
                setTimeout(() => tooltip.style.opacity = '1', 10);
            });
            
            icon.addEventListener('mouseleave', function() {
                const tooltip = this.querySelector('.tooltip');
                if (tooltip) {
                    tooltip.style.opacity = '0';
                    setTimeout(() => tooltip.remove(), 300);
                }
            });
        });
    };
    
    // ===== INICIALIZAÇÃO =====
    const init = () => {
        animateNumbers();
        animateOnScroll();
        addHoverEffects();
        smoothScroll();
        parallaxEffect();
        pulseAnimation();
        showWelcomeMessage();
        lazyLoadImages();
        addTooltips();
        
        console.log('✅ Todas as animações da homepage carregadas');
    };
    
    // Inicializar
    init();
});

// ===== ESTILOS DINÂMICOS =====
const dynamicStyles = `
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.05); }
        100% { transform: scale(1); }
    }
    
    .tooltip {
        z-index: 1000;
    }
    
    .loaded {
        animation: fadeIn 0.5s ease;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
`;

const styleSheet = document.createElement('style');
styleSheet.textContent = dynamicStyles;
document.head.appendChild(styleSheet);

console.log('🌟 Zen Mind Homepage - Pronta para meditação!');